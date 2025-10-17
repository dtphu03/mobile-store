package com.mobilestore.service;

import com.mobilestore.dto.ChatbotRequest;
import com.mobilestore.dto.ChatbotResponse;

public interface ChatbotService {
	ChatbotResponse ask(ChatbotRequest request);
}



