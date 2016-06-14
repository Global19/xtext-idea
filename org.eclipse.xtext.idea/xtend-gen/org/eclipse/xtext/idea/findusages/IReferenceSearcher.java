/**
 * Copyright (c) 2015 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */
package org.eclipse.xtext.idea.findusages;

import com.google.inject.ImplementedBy;
import com.google.inject.Singleton;
import com.intellij.psi.PsiReference;
import com.intellij.psi.search.searches.ReferencesSearch;
import com.intellij.util.Processor;

/**
 * @author kosyakov - Initial contribution and API
 */
@ImplementedBy(IReferenceSearcher.NullReferenceSearcher.class)
@SuppressWarnings("all")
public interface IReferenceSearcher {
  @Singleton
  public static class NullReferenceSearcher implements IReferenceSearcher {
    @Override
    public void processQuery(final ReferencesSearch.SearchParameters queryParameters, final Processor<PsiReference> consumer) {
    }
  }
  
  public abstract void processQuery(final ReferencesSearch.SearchParameters queryParameters, final Processor<PsiReference> consumer);
}
