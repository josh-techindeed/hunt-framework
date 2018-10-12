/*
 * Copyright 2002-2017 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module hunt.framework.messaging.simp.SimpSessionScope;

import org.springframework.beans.factory.ObjectFactory;
import org.springframework.beans.factory.config.Scope;


/**
 * A {@link Scope} implementation exposing the attributes of a SiMP session
 * (e.g. WebSocket session).
 *
 * <p>Relies on a thread-bound {@link SimpAttributes} instance exported by
 * {@link hunt.framework.messaging.simp.annotation.support.SimpAnnotationMethodMessageHandler}.
 *
 * @author Rossen Stoyanchev
 * @since 4.1
 */
public class SimpSessionScope : Scope {

	override
	public Object get(string name, ObjectFactory<?> objectFactory) {
		SimpAttributes simpAttributes = SimpAttributesContextHolder.currentAttributes();
		Object scopedObject = simpAttributes.getAttribute(name);
		if (scopedObject !is null) {
			return scopedObject;
		}
		synchronized (simpAttributes.getSessionMutex()) {
			scopedObject = simpAttributes.getAttribute(name);
			if (scopedObject is null) {
				scopedObject = objectFactory.getObject();
				simpAttributes.setAttribute(name, scopedObject);
			}
			return scopedObject;
		}
	}

	override
	
	public Object remove(string name) {
		SimpAttributes simpAttributes = SimpAttributesContextHolder.currentAttributes();
		synchronized (simpAttributes.getSessionMutex()) {
			Object value = simpAttributes.getAttribute(name);
			if (value !is null) {
				simpAttributes.removeAttribute(name);
				return value;
			}
			else {
				return null;
			}
		}
	}

	override
	public void registerDestructionCallback(string name, Runnable callback) {
		SimpAttributesContextHolder.currentAttributes().registerDestructionCallback(name, callback);
	}

	override
	
	public Object resolveContextualObject(string key) {
		return null;
	}

	override
	public string getConversationId() {
		return SimpAttributesContextHolder.currentAttributes().getSessionId();
	}

}
