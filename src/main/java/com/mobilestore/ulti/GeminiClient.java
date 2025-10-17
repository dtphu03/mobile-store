package com.mobilestore.ulti;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClientResponseException;
import org.springframework.web.client.RestTemplate;

import java.util.*;

@Component
public class GeminiClient {

	@Value("${gemini.api.key:AIzaSyCQZFV2d5hWL6ZcSPGWiln95LoXjfwKKLU}")
	private String apiKey;

	@Value("${gemini.api.model:gemini-1.5-flash-latest}")
	private String model;

	@Value("${gemini.api.url:https://generativelanguage.googleapis.com/v1/models}")
	private String apiBaseUrl;

	private final RestTemplate restTemplate = new RestTemplate();

	public String generateText(String prompt) {
		String url = apiBaseUrl + "/" + model + ":generateContent?key=" + apiKey;

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		// Build payload per Gemini API: { contents: [ { role: "user", parts: [ { text } ] } ] }
		Map<String, Object> textPart = new HashMap<>();
		textPart.put("text", prompt);

		Map<String, Object> contentItem = new HashMap<>();
		contentItem.put("role", "user");
		contentItem.put("parts", new Object[]{ textPart });

		Map<String, Object> requestBody = new HashMap<>();
		requestBody.put("contents", new Object[]{ contentItem });

		HttpEntity<Map<String, Object>> request = new HttpEntity<>(requestBody, headers);

		try {
			Map response = restTemplate.postForObject(url, request, Map.class);
			return extractText(response);
		} catch (RestClientResponseException ex) {
			// Thử nhiều biến thể khi 404 để loại trừ sai endpoint/model
			if (ex.getRawStatusCode() == 404) {
				List<String> baseVariants = Arrays.asList(
					apiBaseUrl,
					apiBaseUrl.replace("/v1beta/", "/v1/"),
					apiBaseUrl.replace("/v1/", "/v1beta/")
				);
				Set<String> modelVariants = new LinkedHashSet<>(Arrays.asList(
					model,
					model.endsWith("-latest") ? model.substring(0, model.length()-7) : (model + "-latest"),
					"gemini-1.5-flash",
					"gemini-1.5-flash-latest",
					"gemini-1.5-pro",
					"gemini-1.5-pro-latest"
				));
				for (String b : baseVariants) {
					for (String m : modelVariants) {
						try {
							String u = b + "/" + m + ":generateContent?key=" + apiKey;
							Map resp2 = restTemplate.postForObject(u, request, Map.class);
							String txt = extractText(resp2);
							if (txt != null && !txt.isEmpty()) return txt;
						} catch (RestClientResponseException ignore) {
							// thử tiếp
						}
					}
				}
			}
			String errorBody = safeBody(ex.getResponseBodyAsString());
			String statusInfo = ex.getRawStatusCode() + " " + ex.getStatusText();
			return "Hệ thống AI đang bận (" + statusInfo + ")" + (errorBody.isEmpty()?"":" - " + errorBody) + ". Vui lòng thử lại sau.";
		}
	}

	private String extractText(Map response) {
		if (response == null) return "";
		Object candidates = response.get("candidates");
		if (!(candidates instanceof List) || ((List) candidates).isEmpty()) return "";
		Object first = ((List) candidates).get(0);
		if (!(first instanceof Map)) return "";
		Object content = ((Map) first).get("content");
		if (!(content instanceof Map)) return "";
		Object parts = ((Map) content).get("parts");
		if (!(parts instanceof List) || ((List) parts).isEmpty()) return "";
		Object firstPart = ((List) parts).get(0);
		if (!(firstPart instanceof Map)) return "";
		Object text = ((Map) firstPart).get("text");
		return text == null ? "" : String.valueOf(text);
	}

	private String safeBody(String s) {
		if (s == null) return "";
		s = s.trim();
		if (s.length() > 300) return s.substring(0, 300) + "...";
		return s;
	}
}


