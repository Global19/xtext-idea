package org.eclipse.xtext.idea.generator

import com.google.inject.Inject
import com.intellij.compiler.server.BuildProcessParametersProvider
import com.intellij.ide.plugins.PluginManager
import com.intellij.lang.ASTNode
import com.intellij.lang.ParserDefinition
import com.intellij.lang.PsiParser
import com.intellij.lexer.Lexer
import com.intellij.openapi.extensions.PluginId
import com.intellij.openapi.fileTypes.SyntaxHighlighter
import com.intellij.openapi.project.Project
import com.intellij.psi.FileViewProvider
import com.intellij.psi.PsiElement
import com.intellij.psi.PsiFile
import com.intellij.psi.impl.PsiTreeChangeEventImpl
import com.intellij.psi.stubs.IStubElementType
import com.intellij.psi.tree.IElementType
import com.intellij.psi.tree.IFileElementType
import com.intellij.psi.util.PsiModificationTracker
import java.util.ArrayList
import java.util.Arrays
import java.util.List
import java.util.Set
import org.eclipse.xpand2.output.Outlet
import org.eclipse.xpand2.output.Output
import org.eclipse.xpand2.output.OutputImpl
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtext.AbstractElement
import org.eclipse.xtext.AbstractRule
import org.eclipse.xtext.CrossReference
import org.eclipse.xtext.Grammar
import org.eclipse.xtext.RuleCall
import org.eclipse.xtext.common.types.access.IJvmTypeProvider
import org.eclipse.xtext.common.types.xtext.AbstractTypeScopeProvider
import org.eclipse.xtext.generator.BindFactory
import org.eclipse.xtext.generator.Binding
import org.eclipse.xtext.generator.Xtend2ExecutionContext
import org.eclipse.xtext.generator.Xtend2GeneratorFragment
import org.eclipse.xtext.generator.grammarAccess.GrammarAccess
import org.eclipse.xtext.idea.annotation.IssueAnnotator
import org.eclipse.xtext.idea.findusages.BaseXtextFindUsageProvider
import org.eclipse.xtext.idea.generator.parser.antlr.GrammarAccessExtensions
import org.eclipse.xtext.idea.generator.parser.antlr.XtextIDEAGeneratorExtensions
import org.eclipse.xtext.idea.jvmmodel.PsiJvmModelAssociator
import org.eclipse.xtext.idea.jvmmodel.codeInsight.PsiJvmTargetElementEvaluator
import org.eclipse.xtext.idea.lang.BaseXtextASTFactory
import org.eclipse.xtext.idea.lang.IElementTypeProvider
import org.eclipse.xtext.idea.parser.AbstractAntlrDelegatingIdeaLexer
import org.eclipse.xtext.idea.parser.AbstractXtextPsiParser
import org.eclipse.xtext.idea.parser.TokenTypeProvider
import org.eclipse.xtext.idea.refactoring.BaseXtextRefactoringSupportProvider
import org.eclipse.xtext.idea.types.JvmTypesShortNamesCache
import org.eclipse.xtext.idea.types.StubBasedTypeScopeProvider
import org.eclipse.xtext.idea.types.access.StubTypeProviderFactory
import org.eclipse.xtext.idea.types.psi.JvmTypesElementFinder
import org.eclipse.xtext.idea.types.psi.search.JvmElementsReferencesSearch
import org.eclipse.xtext.idea.types.stubindex.JvmDeclaredTypeShortNameIndex
import org.eclipse.xtext.psi.BaseXtextCodeBlockModificationListener
import org.eclipse.xtext.psi.BaseXtextElementDescriptionProvider
import org.eclipse.xtext.psi.PsiNamedEObject
import org.eclipse.xtext.psi.impl.PsiEObjectReference
import org.eclipse.xtext.psi.impl.PsiNamedEObjectImpl
import org.eclipse.xtext.psi.stubs.PsiNamedEObjectStub
import org.eclipse.xtext.psi.stubs.PsiNamedEObjectType
import org.eclipse.xtext.psi.stubs.XtextFileElementType
import org.eclipse.xtext.psi.stubs.XtextFileStub
import org.eclipse.xtext.psi.tree.IGrammarAwareElementType
import org.eclipse.xtext.xbase.jvmmodel.JvmModelAssociator
import org.eclipse.xtext.xbase.typesystem.internal.IFeatureScopeTracker
import org.eclipse.xtext.xbase.typesystem.internal.OptimizingFeatureScopeTrackerProvider

import static extension org.eclipse.xtext.GrammarUtil.*

class IdeaPluginGenerator extends Xtend2GeneratorFragment {
	
	private static String META_INF_PLUGIN = "META_INF_PLUGIN"
	
	private static String PLUGIN = "PLUGIN"
	
	private String encoding
	
	private String fileExtension
	
	private Set<String> libraries = newHashSet();
	
	private String pathIdeaPluginProject
	
	@Accessors(PUBLIC_SETTER)
	private String pathRuntimePluginProject
	
	@Accessors(PUBLIC_SETTER)
	private boolean typesIntegrationRequired = false
	
	@Inject
	extension GrammarAccess
	
	@Inject
	extension IdeaPluginExtension
	
	@Inject
	extension IdeaPluginClassNames
	
	@Inject
	extension GrammarAccessExtensions
	
	@Inject
	extension XtextIDEAGeneratorExtensions
	
	override generate(Grammar grammar, Xtend2ExecutionContext ctx) {
//		for (rule:grammar.rules) {
//			ctx.writeFile(Generator::SRC_GEN, grammar.getPsiElementPath(rule), grammar.compilePsiElement(rule))
//			ctx.writeFile(Generator::SRC_GEN, grammar.getPsiElementImplPath(rule), grammar.compilePsiElementImpl(rule))	
//		}
		ctx.installOutlets(pathIdeaPluginProject, encoding)
		
		var outlet_src = ctx.srcOutlet.name
		var outlet_src_gen = ctx.srcGenOutlet.name
		
		val bindFactory = new BindFactory();
		bindFactory.addTypeToType(SyntaxHighlighter.name, grammar.syntaxHighlighterName)
		bindFactory.addTypeToType(Lexer.name, grammar.lexerName)
		bindFactory.addTypeToType(PsiParser.name, grammar.psiParserName)
		bindFactory.addTypeToType(TokenTypeProvider.name, grammar.tokenTypeProviderName)
		bindFactory.addTypeToType(ParserDefinition.name, grammar.parserDefinitionName)
		bindFactory.addTypeToTypeSingleton(IElementTypeProvider.name, grammar.elementTypeProviderName)
		
		if (typesIntegrationRequired) {
			bindFactory.addTypeToType(IJvmTypeProvider.Factory.name, StubTypeProviderFactory.name)
			bindFactory.addTypeToType(AbstractTypeScopeProvider.name, StubBasedTypeScopeProvider.name)
			bindFactory.addTypeToType(JvmModelAssociator.name, PsiJvmModelAssociator.name)
			bindFactory.addTypeToTypeSingleton(JvmDeclaredTypeShortNameIndex.name, JvmDeclaredTypeShortNameIndex.name)
			bindFactory.addTypeToType(IFeatureScopeTracker.Provider.name, OptimizingFeatureScopeTrackerProvider.name)
		}
		val bindings = bindFactory.bindings
		
		ctx.writeFile(outlet_src, grammar.standaloneSetupIdea.toJavaPath, grammar.compileStandaloneSetup)
		ctx.writeFile(outlet_src, grammar.ideaModuleName.toJavaPath, grammar.compileIdeaModule)
		ctx.writeFile(outlet_src_gen, grammar.languageName.toJavaPath, grammar.compileLanguage)
		ctx.writeFile(outlet_src_gen, grammar.fileTypeName.toJavaPath, grammar.compileFileType)
		ctx.writeFile(outlet_src_gen, grammar.fileTypeFactoryName.toJavaPath, grammar.compileFileTypeFactory)
		ctx.writeFile(outlet_src_gen, grammar.fileImplName.toJavaPath, grammar.compileFileImpl)
		ctx.writeFile(outlet_src_gen, grammar.lexerName.toJavaPath, grammar.compileLexer)
		ctx.writeFile(outlet_src_gen, grammar.tokenTypeProviderName.toJavaPath, grammar.compileTokenTypeProvider)
		ctx.writeFile(outlet_src_gen, grammar.elementTypeProviderName.toJavaPath, grammar.compileElementTypeProvider)
		ctx.writeFile(outlet_src_gen, grammar.parserDefinitionName.toJavaPath, grammar.compileParserDefinition)
		ctx.writeFile(outlet_src_gen, grammar.syntaxHighlighterName.toJavaPath, grammar.compileSyntaxHighlighter)
		ctx.writeFile(outlet_src_gen, grammar.syntaxHighlighterFactoryName.toJavaPath, grammar.compileSyntaxHighlighterFactory)
		ctx.writeFile(outlet_src_gen, grammar.abstractIdeaModuleName.toJavaPath, grammar.compileGuiceModuleIdeaGenerated(bindings))
		ctx.writeFile(outlet_src_gen, grammar.extensionFactoryName.toJavaPath, grammar.compileExtensionFactory)
		ctx.writeFile(outlet_src_gen, grammar.buildProcessParametersProviderName.toJavaPath, grammar.compileBuildProcessParametersProvider)
		ctx.writeFile(outlet_src_gen, grammar.codeBlockModificationListenerName.toJavaPath, grammar.compileCodeBlockModificationListener)
		ctx.writeFile(outlet_src_gen, grammar.elementDescriptionProviderName.toJavaPath, grammar.compileElementDescriptionProvider)
		ctx.writeFile(outlet_src_gen, grammar.psiParserName.toJavaPath, grammar.compilePsiParser)
		if (typesIntegrationRequired) {
			ctx.writeFile(outlet_src_gen, grammar.jvmTypesElementFinderName.toJavaPath, grammar.compileJvmTypesElementFinder)
			ctx.writeFile(outlet_src_gen, grammar.jvmTypesShortNamesCacheName.toJavaPath, grammar.compileJvmTypesShortNamesCache)
			ctx.writeFile(outlet_src_gen, grammar.jvmElementsReferencesSearch.toJavaPath, grammar.compileJvmElementsReferencesSearch)
		}
		
		if (pathIdeaPluginProject != null) {
			var output = new OutputImpl();
			output.addOutlet(PLUGIN, pathIdeaPluginProject);
			output.addOutlet(META_INF_PLUGIN, pathIdeaPluginProject + "/META-INF");
			
			output.writeFile(PLUGIN, '''«grammar.name.toSimpleName» Launch Intellij.launch''', grammar.compileLaunchIntellij(pathIdeaPluginProject.split('/').last))
			output.writeFile(META_INF_PLUGIN, "plugin.xml", grammar.compilePluginXml)
		}
	}
	
	def CharSequence compileGuiceModuleIdeaGenerated(Grammar grammar, Set<Binding> bindings) '''
		package «grammar.abstractIdeaModuleName.toPackageName»;
		
		public class «grammar.abstractIdeaModuleName.toSimpleName» extends org.eclipse.xtext.idea.DefaultIdeaModule {
			
			«FOR it : bindings»
				«IF !value.provider && value.statements.isEmpty»
					// contributed by «contributedBy»
					«IF key.singleton»@org.eclipse.xtext.service.SingletonBinding«IF key.eagerSingleton»(eager=true)«ENDIF»«ENDIF»
					public «IF value.expression==null»Class<? extends «key.type»>«ELSE»«key.type»«ENDIF» «bindMethodName(it)»() {
						return «IF value.expression!=null»«value.expression»«ELSE»«value.typeName».class«ENDIF»;
					}
				«ELSEIF value.statements.isEmpty»
					// contributed by «contributedBy»
					«IF key.singleton»@org.eclipse.xtext.service.SingletonBinding«IF key.eagerSingleton»(eager=true)«ENDIF»«ENDIF»
					public «IF value.expression==null»Class<? extends com.google.inject.Provider<«key.type»>>«ELSE»com.google.inject.Provider<«key.type»>«ENDIF» «bindMethodName(it)»() {
						return «IF value.expression!=null»«value.expression»«ELSE»«value.typeName».class«ENDIF»;
					}
				«ELSE»
					// contributed by «contributedBy»
					public void «bindMethodName(it)»(com.google.inject.Binder binder) {
						«FOR statement : value.statements»
						«statement»«IF !statement.endsWith(";")»;«ENDIF»
						«ENDFOR»
					}
				«ENDIF»
			«ENDFOR»
			
			
		}
	'''
	
	def bindMethodName(Binding it) {
		val prefix = if (!it.value.provider && it.value.statements.isEmpty) 
			'bind' 
		else {
			if (it.value.statements.isEmpty)
				'provide'
			else 
				'configure'
		}
		val suffix = if (value.expression!=null && !value.provider) 'ToInstance' else ''
		return prefix + simpleMethodName(key.type) + suffix
	}
	
	def private simpleMethodName(String qn) {
		qn.replaceAll('<','\\.').replaceAll('>','\\.').split('\\.').filter(e|e.matches('[A-Z].*')).join('$');
	}
	
	def compileExtensionFactory(Grammar grammar) '''
		package «grammar.extensionFactoryName.toPackageName»;
		
		import «grammar.languageName»;
		
		import com.intellij.openapi.extensions.ExtensionFactory;
		
		public class «grammar.extensionFactoryName.toSimpleName» implements ExtensionFactory {

			public Object createInstance(final String factoryArgument, final String implementationClass) {
				Class<?> clazz;
				try {
					clazz = Class.forName(implementationClass);
				} catch (ClassNotFoundException e) {
					throw new IllegalArgumentException("Couldn't load "+implementationClass, e);
				}
				return «grammar.languageName.toSimpleName».INSTANCE.<Object> getInstance(clazz);
			}

		}
	'''
	
	def compileBuildProcessParametersProvider(Grammar grammar) '''
		package «grammar.buildProcessParametersProviderName.toPackageName»;

		import «Arrays.name»;
		import «List.name»;
		
		import «BuildProcessParametersProvider.name»;
		import «PluginManager.name»;
		import «PluginId.name»;
		
		public class «grammar.buildProcessParametersProviderName.toSimpleName» extends «BuildProcessParametersProvider.simpleName» {
		
			public List<String> getClassPath() {
				String path = PluginManager.getPlugin(PluginId.getId("«grammar.languageID»")).getPath().getPath();
				return Arrays.asList(
					path + "/bin", 
					path + "/../«pathRuntimePluginProject»/bin"
				);
			}
		
		}
	'''
	
	def compileCodeBlockModificationListener(Grammar grammar) '''
		package «grammar.codeBlockModificationListenerName.toPackageName»;
		
		«IF typesIntegrationRequired»
		import «PsiTreeChangeEventImpl.name»;
		«ENDIF»
		import «PsiModificationTracker.name»;
		import «BaseXtextCodeBlockModificationListener.name»;
		import «grammar.languageName»;
		
		public class «grammar.codeBlockModificationListenerName.toSimpleName» extends «BaseXtextCodeBlockModificationListener.simpleName» {
		
			public «grammar.codeBlockModificationListenerName.toSimpleName»(«PsiModificationTracker.simpleName» psiModificationTracker) {
				super(«grammar.languageName.toSimpleName».INSTANCE, psiModificationTracker);
			}
		«IF typesIntegrationRequired»
		
			protected boolean hasJavaStructuralChanges(«PsiTreeChangeEventImpl.simpleName» event) {
				return true;
			}
		«ENDIF»
		
		}
	'''
	
	def compileElementDescriptionProvider(Grammar grammar) '''
		package «grammar.elementDescriptionProviderName.toPackageName»;
		
		import «BaseXtextElementDescriptionProvider.name»;
		import «grammar.languageName»;
		
		public class «grammar.elementDescriptionProviderName.toSimpleName» extends «BaseXtextElementDescriptionProvider.simpleName» {
		
			public «grammar.elementDescriptionProviderName.toSimpleName»() {
				super(«grammar.languageName.toSimpleName».INSTANCE);
			}
		
		}
	'''
	
	def compilePsiParser(Grammar grammar) '''
		package «grammar.psiParserName.toPackageName»;
		
		import java.io.IOException;
		
		import org.antlr.runtime.ANTLRReaderStream;
		import org.antlr.runtime.TokenSource;
		import org.antlr.runtime.TokenStream;
		import «AbstractXtextPsiParser.name»;
		import org.eclipse.xtext.idea.parser.AbstractPsiAntlrParser;
		import org.eclipse.xtext.xbase.lib.Exceptions;
		import «grammar.elementTypeProviderName»;
		import «grammar.psiInternalLexerName»;
		import «grammar.psiInternalParserName»;
		
		import com.google.inject.Inject;
		import com.intellij.lang.PsiBuilder;
		import com.intellij.util.text.CharSequenceReader;
		
		public class «grammar.psiParserName.toSimpleName» extends AbstractXtextPsiParser {
			
			@Inject 
			private «grammar.elementTypeProviderName.toSimpleName» elementTypeProvider;
		
			@Override
			protected AbstractPsiAntlrParser createParser(PsiBuilder builder, TokenStream tokenStream) {
				return new «grammar.psiInternalParserName.toSimpleName»(builder, tokenStream, getTokenTypeProvider(), elementTypeProvider);
			}
		
			@Override
			protected TokenSource createTokenSource(PsiBuilder builder) {
				try {
					CharSequence originalText = builder.getOriginalText();
					CharSequenceReader reader = new CharSequenceReader(originalText);
					return new «grammar.psiInternalLexerName.toSimpleName»(new ANTLRReaderStream(reader));
				} catch (IOException e) {
					throw Exceptions.sneakyThrow(e);
				}
			}
		
		}
	'''
	
	def compileJvmTypesShortNamesCache(Grammar grammar) '''
		package «grammar.jvmTypesShortNamesCacheName.toPackageName»;
		
		import «Project.name»;
		import «JvmTypesShortNamesCache.name»;
		import «grammar.languageName»;
		
		class «grammar.jvmTypesShortNamesCacheName.toSimpleName» extends «JvmTypesShortNamesCache.simpleName» {
		
			public «grammar.jvmTypesShortNamesCacheName.toSimpleName»(«Project.simpleName» project) {
				super(«grammar.languageName.toSimpleName».INSTANCE, project);
			}
		
		}
	'''
	
	def compileJvmElementsReferencesSearch(Grammar grammar) '''
		package «grammar.jvmElementsReferencesSearch.toPackageName»;

		import «JvmElementsReferencesSearch.name»;
		import «grammar.languageName»;
		
		public class «grammar.jvmElementsReferencesSearch.toSimpleName» extends «JvmElementsReferencesSearch.simpleName» {
		
			public «grammar.jvmElementsReferencesSearch.toSimpleName»() {
				super(«grammar.languageName.toSimpleName».INSTANCE);
			}
		
		}
	'''
	
	def compileJvmTypesElementFinder(Grammar grammar) '''
		package «grammar.jvmTypesElementFinderName.toPackageName»;
		
		import «Project.name»;
		import «JvmTypesElementFinder.name»;
		import «grammar.languageName»;
		
		public class «grammar.jvmTypesElementFinderName.toSimpleName» extends «JvmTypesElementFinder.simpleName» {
		
			public «grammar.jvmTypesElementFinderName.toSimpleName»(«Project.simpleName» project) {
				super(«grammar.languageName.toSimpleName».INSTANCE, project);
			}
		
		}
	'''
	
	def iml() {
		pathIdeaPluginProject.substring(pathIdeaPluginProject.lastIndexOf("/") + 1) + ".iml"
	}
	
	def addOutlet(Output output, String outletName, String path) {
		output.addOutlet(new Outlet(false, getEncoding(), outletName, false, path))
	}
	
	def writeFile(Output output, String outletName, String filename, CharSequence contents) {
		output.openFile(filename, outletName);
		output.write(contents.toString);
		output.closeFile();
	}
	
	def getEncoding() {
		if (encoding != null) {
			return encoding;
		}
		return System::getProperty("file.encoding");
	}
	
	def addLibrary(String library) {
		libraries.add(library)
	}
	
	def setFileExtensions(String fileExtensions) {
		this.fileExtension = fileExtensions.split("\\s*,\\s*").head
	}
	
	def void setEncoding(String encoding) {
		this.encoding = encoding
	}
	
	def setPathIdeaPluginProject(String pathIdeaPluginProject) {
		this.pathIdeaPluginProject = pathIdeaPluginProject
	}
	
	def compilePluginXml(Grammar grammar)'''
		<idea-plugin version="2">
			<id>«grammar.languageID»</id>
			<name>«grammar.simpleName» Support</name>
			<description>
		      This plugin enables smart editing of «grammar.simpleName» files.
			</description>
			<version>1.0.0</version>
			<vendor>My Company</vendor>
		
			<idea-version since-build="131"/>

			<extensions defaultExtensionNs="com.intellij">
				<buildProcess.parametersProvider implementation="«grammar.buildProcessParametersProviderName»"/>
				«IF typesIntegrationRequired»
				
				<java.elementFinder implementation="«grammar.jvmTypesElementFinderName»"/>
				<java.shortNamesCache implementation="«grammar.jvmTypesShortNamesCacheName»"/>
				«ENDIF»
		
				<stubIndex implementation="org.eclipse.xtext.psi.stubindex.ExportedObjectQualifiedNameIndex"/>
				«IF typesIntegrationRequired»
				<stubIndex implementation="org.eclipse.xtext.idea.types.stubindex.JvmDeclaredTypeShortNameIndex"/>
				«ENDIF»
		
				<psi.treeChangePreprocessor implementation="«grammar.codeBlockModificationListenerName»"/>
				«IF typesIntegrationRequired»

				<referencesSearch implementation="«grammar.jvmElementsReferencesSearch»"/>
				«grammar.compileExtension('targetElementEvaluator', PsiJvmTargetElementEvaluator.name)»
				«ENDIF»
		
				<fileTypeFactory implementation="«grammar.fileTypeFactoryName»"/>
				<stubElementTypeHolder class="«grammar.elementTypeProviderName»"/>
				«grammar.compileExtension('lang.ast.factory', BaseXtextASTFactory.name)»
				«grammar.compileExtension('lang.parserDefinition', grammar.parserDefinitionName)»
				«grammar.compileExtension('lang.findUsagesProvider', BaseXtextFindUsageProvider.name)»
				«grammar.compileExtension('lang.refactoringSupport', BaseXtextRefactoringSupportProvider.name)»
		      	<lang.syntaxHighlighterFactory key="«grammar.languageID»" implementationClass="«grammar.syntaxHighlighterFactoryName»" />
		      	«grammar.compileExtension('annotator', IssueAnnotator.name)»
		      	<elementDescriptionProvider implementation="«grammar.elementDescriptionProviderName»" order="first"/>
			</extensions>
		
		</idea-plugin>
	'''
	
	def compileExtension(Grammar grammar, String extensionPointId, String implementationClass) '''
		<«extensionPointId» language="«grammar.languageID»"
								factoryClass="«grammar.extensionFactoryName»"
								implementationClass="«implementationClass»"/>
	'''
	
	def compileLaunchIntellij(Grammar grammar, String path)'''
		<?xml version="1.0" encoding="UTF-8" standalone="no"?>
			<launchConfiguration type="org.eclipse.jdt.launching.localJavaApplication">
			<stringAttribute key="bad_container_name" value="/«path»/«grammar.name.toSimpleName.toLowerCase»_launch_intellij.launch"/>
			<listAttribute key="org.eclipse.debug.core.MAPPED_RESOURCE_PATHS">
				<listEntry value="/«path»"/>
			</listAttribute>
			<listAttribute key="org.eclipse.debug.core.MAPPED_RESOURCE_TYPES">
				<listEntry value="4"/>
			</listAttribute>
			<booleanAttribute key="org.eclipse.jdt.launching.ATTR_USE_START_ON_FIRST_THREAD" value="false"/>
			<stringAttribute key="org.eclipse.jdt.launching.JRE_CONTAINER" value="org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.launching.macosx.MacOSXType/Java SE 6 [1.6.0_65-b14-462]"/>
			<stringAttribute key="org.eclipse.jdt.launching.MAIN_TYPE" value="com.intellij.idea.Main"/>
			<stringAttribute key="org.eclipse.jdt.launching.PROJECT_ATTR" value="«path»"/>
			<stringAttribute key="org.eclipse.jdt.launching.VM_ARGUMENTS" value="-Xmx2g -XX:MaxPermSize=320m -Didea.plugins.path=${INTELLIJ_IDEA_PLUGINS} -Didea.home.path=${INTELLIJ_IDEA} -Didea.ProcessCanceledException=disabled -Dcompiler.process.debug.port=-1"/>
		</launchConfiguration>
	'''
	
	def compilePsiElement(Grammar grammar, AbstractRule rule)'''
		package «grammar.psiPackageName»;
		«IF rule.hasMultipleAssigment»
		
		import java.util.List;
		«ENDIF»
		
		import com.intellij.psi.«rule.psiElementSuperClassName»;
		
		public interface «rule.psiElementClassName» extends «rule.psiElementSuperClassName» {
			«FOR assignment:rule.assignmentsWithoutName»
			
			«assignment.typeName» «assignment.getter»();
			
			void «assignment.setter»(«assignment.typeName» «assignment.feature»);
			«ENDFOR»
		
		}
	'''
	
	def compileFileImpl(Grammar grammar)'''
		package «grammar.psiImplPackageName»;
		
		import org.eclipse.xtext.psi.impl.BaseXtextFile;
		import «grammar.fileTypeName»;
		import «grammar.languageName»;
		
		import com.intellij.openapi.fileTypes.FileType;
		import com.intellij.psi.FileViewProvider;
		
		public final class «grammar.fileImplName.toSimpleName» extends BaseXtextFile {
		
			public «grammar.fileImplName.toSimpleName»(FileViewProvider viewProvider) {
				super(viewProvider, «grammar.languageName.toSimpleName».INSTANCE);
			}
		
			public FileType getFileType() {
				return «grammar.fileTypeName.toSimpleName».INSTANCE;
			}
		
		}
	'''
	
	def compileFileTypeFactory(Grammar grammar)'''
		package «grammar.fileTypeFactoryName.toPackageName»;
		
		import com.intellij.openapi.fileTypes.FileTypeConsumer;
		import com.intellij.openapi.fileTypes.FileTypeFactory;
		import org.jetbrains.annotations.NotNull;
		
		public class «grammar.fileTypeFactoryName.toSimpleName» extends FileTypeFactory {
		
			public void createFileTypes(@NotNull FileTypeConsumer consumer) {
				consumer.consume(«grammar.fileTypeName».INSTANCE, «grammar.fileTypeName».DEFAULT_EXTENSION);
			}
		
		}
	'''
	
	def compileFileType(Grammar grammar)'''
		package «grammar.fileTypeName.toPackageName»;
		
		import javax.swing.Icon;
		
		import com.intellij.openapi.fileTypes.LanguageFileType;
		import org.jetbrains.annotations.NonNls;
		
		public final class «grammar.fileTypeName.toSimpleName» extends LanguageFileType {
		
			public static final «grammar.fileTypeName.toSimpleName» INSTANCE = new «grammar.fileTypeName.toSimpleName»();
			
			@NonNls 
			public static final String DEFAULT_EXTENSION = "«fileExtension»";
		
			private «grammar.fileTypeName.toSimpleName»() {
				super(«grammar.languageName.toSimpleName».INSTANCE);
			}
		
			public String getDefaultExtension() {
				return DEFAULT_EXTENSION;
			}
		
			public String getDescription() {
				return "«grammar.simpleName» files";
			}
		
			public Icon getIcon() {
				return null;
			}
		
			public String getName() {
				return "«grammar.simpleName»";
			}
		
		}
	'''
	
	def compileLanguage(Grammar grammar)'''
		package «grammar.languageName.toPackageName»;
		
		import org.eclipse.xtext.idea.lang.AbstractXtextLanguage;
		
		import com.google.inject.Injector;
		
		public final class «grammar.languageName.toSimpleName» extends AbstractXtextLanguage {
		
			public static final «grammar.languageName.toSimpleName» INSTANCE = new «grammar.languageName.toSimpleName»();
		
			private Injector injector;
		
			private «grammar.languageName.toSimpleName»() {
				super("«grammar.languageID»");
				this.injector = new «grammar.standaloneSetupIdea»().createInjectorAndDoEMFRegistration();
				
			}
		
			@Override
			protected Injector getInjector() {
				return injector;
			}
		}
	'''
	
	def compileStandaloneSetup(Grammar grammar) '''
		package «grammar.standaloneSetupIdea.toPackageName»;
		
		import org.eclipse.xtext.util.Modules2;
		import «naming.setupImpl(grammar)»;
		
		import com.google.inject.Guice;
		import com.google.inject.Injector;
		import com.google.inject.Module;
		
		public class «grammar.standaloneSetupIdea.toSimpleName» extends «naming.toSimpleName(naming.setupImpl(grammar))» {
		
		    @Override
		    public Injector createInjector() {
		        Module runtimeModule = new «naming.guiceModuleRt(grammar)»();
		        Module ideaModule = new «grammar.ideaModuleName»();
		        Module mergedModule = Modules2.mixin(runtimeModule, ideaModule);
		        return Guice.createInjector(mergedModule);
		    }
		
		}
	'''
	
	def compileIdeaModule(Grammar grammar) '''
		package «grammar.ideaModuleName.toPackageName»;
		
		public class «grammar.ideaModuleName.toSimpleName» extends «grammar.abstractIdeaModuleName.toSimpleName» {
		
		}
	'''
	
	def compileElementTypeProvider(Grammar grammar) '''
		package «grammar.elementTypeProviderName.toPackageName»;
		
		import java.util.HashMap;
		import java.util.Map;
		
		import org.eclipse.emf.ecore.EObject;
		import «IElementTypeProvider.name»;
		import «psiNamedEObject.name»;
		import «psiNamedEObjectStub.name»;
		import «psiNamedEObjectType.name»;
		import «XtextFileElementType.name»;
		import «XtextFileStub.name»;
		import «grammar.fileImplName»;
		
		import «IStubElementType.name»;
		import «IElementType.name»;
		import «IFileElementType.name»;
		import «IGrammarAwareElementType.name»;
		import «grammar.grammarAccessName»;
		
		public class «grammar.elementTypeProviderName.toSimpleName» implements IElementTypeProvider {
		
			public static final IFileElementType FILE_TYPE = new «XtextFileElementType.simpleName»<«XtextFileStub.simpleName»<«grammar.fileImplName.toSimpleName»>>(«grammar.languageName.toSimpleName».INSTANCE);
		
			public static final IElementType NAME_TYPE = new IElementType("NAME", «grammar.languageName.toSimpleName».INSTANCE);
		
			public static final IElementType EOBJECT_TYPE = new IElementType("EOBJECT_TYPE", «grammar.languageName.toSimpleName».INSTANCE);
		
			public static final IStubElementType<«psiNamedEObjectStub.simpleName», «psiNamedEObject.simpleName»> NAMED_EOBJECT_TYPE = new «psiNamedEObjectType.simpleName»("NAMED_EOBJECT", «grammar.languageName.toSimpleName».INSTANCE);
		
			public static final IElementType CROSS_REFERENCE_TYPE = new IElementType("CROSS_REFERENCE", «grammar.languageName.toSimpleName».INSTANCE);
			«FOR rule:grammar.allRules»
			
			public static final «IGrammarAwareElementType.simpleName» «rule.grammarElementIdentifier»_ELEMENT_TYPE;
			«FOR element:rule.eAllContents.filter(AbstractElement).toIterable»
			
			public static final «IGrammarAwareElementType.simpleName» «element.grammarElementIdentifier»_ELEMENT_TYPE;
			«ENDFOR»
			«ENDFOR»
		
			private static final Map<EObject, IGrammarAwareElementType> GRAMMAR_ELEMENT_TYPE = new HashMap<EObject, IGrammarAwareElementType>();
		
			static {
				«grammar.grammarAccessName.toSimpleName» grammarAccess = «grammar.languageName.toSimpleName».INSTANCE.getInstance(«grammar.grammarAccessName.toSimpleName».class);
				«FOR rule:grammar.allRules»
				
				«rule.grammarElementIdentifier»_ELEMENT_TYPE =  new «IGrammarAwareElementType.simpleName»("«rule.grammarElementIdentifier»_ELEMENT_TYPE", «grammar.languageName.toSimpleName».INSTANCE, grammarAccess.«rule.gaRuleAccessor»);
				GRAMMAR_ELEMENT_TYPE.put(grammarAccess.«rule.gaRuleAccessor», «rule.grammarElementIdentifier»_ELEMENT_TYPE);
				«FOR element:rule.eAllContents.filter(AbstractElement).toIterable»
				«element.grammarElementIdentifier»_ELEMENT_TYPE =  new «IGrammarAwareElementType.simpleName»("«element.grammarElementIdentifier»_ELEMENT_TYPE", «grammar.languageName.toSimpleName».INSTANCE, grammarAccess.«rule.gaElementsAccessor».«element.gaElementAccessor»);
				GRAMMAR_ELEMENT_TYPE.put(grammarAccess.«rule.gaElementsAccessor».«element.gaElementAccessor», «element.grammarElementIdentifier»_ELEMENT_TYPE);
				«ENDFOR»
				«ENDFOR»
			}
		
			public IFileElementType getFileType() {
				return FILE_TYPE;
			}
		
			public IElementType getObjectType() {
				return EOBJECT_TYPE;
			}
		
			public IElementType getCrossReferenceType() {
				return CROSS_REFERENCE_TYPE;
			}
		
			public IElementType getNameType() {
				return NAME_TYPE;
			}
		
			public IStubElementType<«psiNamedEObjectStub.simpleName», «psiNamedEObject.simpleName»> getNamedObjectType() {
				return NAMED_EOBJECT_TYPE;
			}
			«FOR rule:grammar.allRules»
			
			public «IGrammarAwareElementType.simpleName» get«rule.grammarElementIdentifier»ElementType() {
				return «rule.grammarElementIdentifier»_ELEMENT_TYPE;
			}
			«FOR element:rule.eAllContents.filter(AbstractElement).toIterable»
			
			public «IGrammarAwareElementType.simpleName» get«element.grammarElementIdentifier»ElementType() {
				return «element.grammarElementIdentifier»_ELEMENT_TYPE;
			}
			«ENDFOR»
			«ENDFOR»
		
			public IGrammarAwareElementType findElementType(EObject grammarElement) {
				return GRAMMAR_ELEMENT_TYPE.get(grammarElement);
			}
		
		}
	'''
	
	def Class<?> getPsiNamedEObjectType() {
		PsiNamedEObjectType
	}
	
	def Class<?> getPsiNamedEObjectStub() {
		PsiNamedEObjectStub
	}
	
	def Class<?> getPsiNamedEObject() {
		PsiNamedEObject
	}
	
	def compileTokenTypeProvider(Grammar grammar)'''
		package «grammar.tokenTypeProviderName.toPackageName»;
		
		import static «grammar.psiInternalParserName».*;
		
		import «TokenTypeProvider.name»;
		import «grammar.languageName»;
		
		import com.google.inject.Singleton;
		import com.intellij.psi.tree.IElementType;
		import com.intellij.psi.tree.TokenSet;
		
		@Singleton public class «grammar.tokenTypeProviderName.toSimpleName» implements TokenTypeProvider {
		
			private static final IElementType[] tokenTypes = new IElementType[tokenNames.length];
			
			static {
				for (int i = 0; i < tokenNames.length; i++) {
					tokenTypes[i] = new IndexedElementType(tokenNames[i], i, «grammar.languageName.toSimpleName».INSTANCE);
				}
			}
			
			private static final TokenSet WHITESPACE_TOKENS = TokenSet.create(tokenTypes[RULE_WS]);
			private static final TokenSet COMMENT_TOKENS = TokenSet.create(tokenTypes[RULE_SL_COMMENT], tokenTypes[RULE_ML_COMMENT]);
			private static final TokenSet STRING_TOKENS = TokenSet.create(tokenTypes[RULE_STRING]);
		
		    public int getAntlrType(IElementType iElementType) {
		        return ((IndexedElementType)iElementType).getLocalIndex();
		    }
		    
		    public IElementType getIElementType(int antlrType) {
		    	return tokenTypes[antlrType];
		    }
		
			@Override
			public TokenSet getWhitespaceTokens() {
				return WHITESPACE_TOKENS;
			}
		
			@Override
			public TokenSet getCommentTokens() {
				return COMMENT_TOKENS;
			}
		
			@Override
			public TokenSet getStringLiteralTokens() {
				return STRING_TOKENS;
			}
		
		}
	'''
	
	def compileLexer(Grammar grammar)'''
		package «grammar.lexerName.toPackageName»;
		
		import org.antlr.runtime.ANTLRStringStream;
		import org.antlr.runtime.Lexer;
		import «AbstractAntlrDelegatingIdeaLexer.name»;
		import «grammar.antlrLexerName»;
		
		public class «grammar.lexerName.toSimpleName» extends AbstractAntlrDelegatingIdeaLexer {
		
			@Override
			public Lexer createAntlrLexer(String text) {
				return new «grammar.antlrLexerName.toSimpleName»(new ANTLRStringStream(text));
			}
		
		}
	'''
	
	def compileSyntaxHighlighterFactory(Grammar grammar)'''
		package «grammar.syntaxHighlighterFactoryName.toPackageName»;
		
		import org.jetbrains.annotations.NotNull;
		
		import com.intellij.openapi.fileTypes.SingleLazyInstanceSyntaxHighlighterFactory;
		import com.intellij.openapi.fileTypes.SyntaxHighlighter;
		
		public class «grammar.syntaxHighlighterFactoryName.toSimpleName» extends SingleLazyInstanceSyntaxHighlighterFactory {
			
		    @NotNull
		    protected SyntaxHighlighter createHighlighter() {
		        return «grammar.languageName.toSimpleName».INSTANCE.getInstance(SyntaxHighlighter.class);
		    }
		
		}
	'''
	
	def compileSyntaxHighlighter(Grammar grammar)'''
		package «grammar.syntaxHighlighterName.toPackageName»;
		
		import «TokenTypeProvider.name»;
		import org.jetbrains.annotations.NotNull;
		import «grammar.antlrLexerName»;
		
		import com.google.inject.Inject;
		import com.google.inject.Provider;
		import com.intellij.lexer.Lexer;
		import com.intellij.openapi.editor.DefaultLanguageHighlighterColors;
		import com.intellij.openapi.editor.colors.TextAttributesKey;
		import com.intellij.openapi.fileTypes.SyntaxHighlighterBase;
		import com.intellij.psi.tree.IElementType;
		
		public class «grammar.syntaxHighlighterName.toSimpleName» extends SyntaxHighlighterBase {
		
			@Inject TokenTypeProvider tokenTypeProvider;
			@Inject Provider<Lexer> lexerProvider; 
		
		    @NotNull
		    public Lexer getHighlightingLexer() {
		        return lexerProvider.get();
		    }
		
		    @NotNull
		    public TextAttributesKey[] getTokenHighlights(IElementType tokenType) {
		        if (tokenTypeProvider.getStringLiteralTokens().contains(tokenType)) {
		            return pack(DefaultLanguageHighlighterColors.STRING);
		        }
				if (tokenTypeProvider.getIElementType(«grammar.antlrLexerName.toSimpleName».RULE_SL_COMMENT) == tokenType) {
					return pack(DefaultLanguageHighlighterColors.LINE_COMMENT);
				}
				if (tokenTypeProvider.getIElementType(«grammar.antlrLexerName.toSimpleName».RULE_ML_COMMENT) == tokenType) {
					return pack(DefaultLanguageHighlighterColors.BLOCK_COMMENT);
				}
		        String myDebugName = tokenType.toString();
				if (myDebugName.matches("^'.*\\w.*'$")) {
					return pack(DefaultLanguageHighlighterColors.KEYWORD);
		        }
		        return new TextAttributesKey[0];
		    }
		
		}
	'''
	
	def compileParserDefinition(Grammar grammar)'''
		package «grammar.parserDefinitionName.toPackageName»;
		
		«IF !grammar.eAllContents.filter(CrossReference).filter[assigned].empty»
		import «PsiEObjectReference.name»;
		«ENDIF»
		import «grammar.elementTypeProviderName»;
		import «grammar.fileImplName»;
		import «grammar.superParserDefinitionName»;
		«IF grammar.eAllContents.filter(RuleCall).filter[assigned && containingAssignment.feature == 'name'].exists[ nameRuleCall |
			!grammar.eAllContents.filter(RuleCall).filter[rule.eAllContents.exists[it == nameRuleCall]].empty
		]»
		import «PsiNamedEObjectImpl.name»;
		«ENDIF»
		
		import «Inject.name»;
		import «ASTNode.name»;
		import «FileViewProvider.name»;
		import «PsiElement.name»;
		import «PsiFile.name»;
		import «IElementType.name»;

		public class «grammar.parserDefinitionName.toSimpleName» extends «grammar.superParserDefinitionName.toSimpleName» {

			@Inject 
			private «grammar.elementTypeProviderName.toSimpleName» elementTypeProvider;
		
			public PsiFile createFile(FileViewProvider viewProvider) {
				return new «grammar.fileImplName.toSimpleName»(viewProvider);
			}
		
			@Override
			@SuppressWarnings("rawtypes")
			public PsiElement createElement(ASTNode node) {
				IElementType elementType = node.getElementType();
				«FOR nameRuleCall:grammar.eAllContents.filter(RuleCall).filter[assigned && containingAssignment.feature == 'name'].toIterable»
				«FOR ruleCall:grammar.eAllContents.filter(RuleCall).filter[rule.eAllContents.exists[it == nameRuleCall]].toIterable»
				if (elementType == elementTypeProvider.get«ruleCall.grammarElementIdentifier»ElementType()) {
					return new «PsiNamedEObjectImpl.simpleName»(node, elementTypeProvider.get«nameRuleCall.grammarElementIdentifier»ElementType());
				}
				«ENDFOR»
				«ENDFOR»
				«FOR crossReference:grammar.eAllContents.filter(CrossReference).filter[assigned].toIterable»
				if (elementType == elementTypeProvider.get«crossReference.grammarElementIdentifier»ElementType()) {
					return new «PsiEObjectReference.simpleName»(node);
				}
				«ENDFOR»
				return super.createElement(node);
			}
		
		}
	'''

}