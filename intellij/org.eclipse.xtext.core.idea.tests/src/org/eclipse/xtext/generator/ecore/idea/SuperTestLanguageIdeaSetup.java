/*
 * generated by Xtext
 */
package org.eclipse.xtext.generator.ecore.idea;

import com.google.inject.Injector;
import org.eclipse.xtext.ISetup;
import org.eclipse.xtext.idea.extensions.EcoreGlobalRegistries;

public class SuperTestLanguageIdeaSetup implements ISetup {

	@Override
	public Injector createInjectorAndDoEMFRegistration() {
		EcoreGlobalRegistries.ensureInitialized();
		return new SuperTestLanguageStandaloneSetupIdea().createInjector();
	}

}
