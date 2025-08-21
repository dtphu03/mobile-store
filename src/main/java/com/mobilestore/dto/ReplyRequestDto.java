package com.mobilestore.dto;

import javax.validation.constraints.NotBlank;

public class ReplyRequestDto {

	@NotBlank(message = "Reply content is required")
	private String content;

	public ReplyRequestDto() {
	}

	public ReplyRequestDto(String content) {
		this.content = content;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}


