async function askChatbot(question) {
	try {
		const res = await fetch(window.location.origin + '/mobilestore/api/chatbot/ask', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({ question })
		});
		if (!res.ok) throw new Error('Request failed');
		const data = await res.json();
		return data && data.answer ? data.answer : '';
	} catch (e) {
		console.error('askChatbot error', e);
		return 'Xin lỗi, hệ thống đang bận. Vui lòng thử lại sau.';
	}
}

window.askChatbot = askChatbot;



