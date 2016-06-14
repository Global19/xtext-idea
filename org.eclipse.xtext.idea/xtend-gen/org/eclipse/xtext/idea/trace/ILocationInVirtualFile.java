/**
 * Copyright (c) 2015 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */
package org.eclipse.xtext.idea.trace;

import org.eclipse.xtext.generator.trace.internal.IPlatformSpecificLocation;
import org.eclipse.xtext.idea.trace.VirtualFileInProject;

/**
 * @author Sebastian Zarnekow - Initial contribution and API
 * @since 2.9
 */
@SuppressWarnings("all")
public interface ILocationInVirtualFile extends IPlatformSpecificLocation<VirtualFileInProject> {
}
