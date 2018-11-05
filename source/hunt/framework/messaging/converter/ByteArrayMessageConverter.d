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

module hunt.framework.messaging.converter.ByteArrayMessageConverter;

import hunt.framework.messaging.converter.AbstractMessageConverter;

import hunt.framework.messaging.Message;
import hunt.framework.messaging.MessageHeaders;
// import hunt.framework.util.MimeTypeUtils;
import hunt.http.codec.http.model.MimeTypes;

/**
 * A {@link MessageConverter} that supports MIME type "application/octet-stream" with the
 * payload converted to and from a byte[].
 *
 * @author Rossen Stoyanchev
 * @since 4.0
 */
class ByteArrayMessageConverter : AbstractMessageConverter {

	this() {
		super(new MimeType("application/octet-stream"));
	}


	// override
	// protected bool supports(Class<?> clazz) {
	// 	return (byte[].class == clazz);
	// }

	// override
	// protected Object convertFromInternal(
	// 		MessageBase message, Class<?> targetClass, Object conversionHint) {

	// 	return message.getPayload();
	// }

	// override
	// protected Object convertToInternal(
	// 		Object payload, MessageHeaders headers, Object conversionHint) {

	// 	return payload;
	// }

}