package com.mobilestore.api;

import com.mobilestore.dto.ChatbotRequest;
import com.mobilestore.dto.ChatbotResponse;
import com.mobilestore.service.ChatbotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/chatbot")
public class ChatbotApi {

	@Autowired
	private ChatbotService chatbotService;

	@PostMapping("/ask")
	public ChatbotResponse ask(@RequestBody ChatbotRequest request) {
		return chatbotService.ask(request);
	}
}



