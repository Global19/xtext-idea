/*
 * generated by Xtext
 */
package org.eclipse.xtext.generator.ecore.idea;

import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.Module;
import org.eclipse.xtext.generator.ecore.SubTestLanguageRuntimeModule;
import org.eclipse.xtext.generator.ecore.SubTestLanguageStandaloneSetupGenerated;
import org.eclipse.xtext.util.Modules2;

public class SubTestLanguageStandaloneSetupIdea extends SubTestLanguageStandaloneSetupGenerated {
	@Override
	public Injector createInjector() {
		SubTestLanguageRuntimeModule runtimeModule = new SubTestLanguageRuntimeModule();
		SubTestLanguageIdeaModule ideaModule = new SubTestLanguageIdeaModule();
		Module mergedModule = Modules2.mixin(runtimeModule, ideaModule);
		return Guice.createInjector(mergedModule);
	}
}
