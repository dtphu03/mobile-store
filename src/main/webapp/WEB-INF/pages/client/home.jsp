<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Mobile Store</title>
    <link rel="stylesheet" href="<c:url value='/Frontend/css/chat.css' />">
</head>
<body>
    <jsp:include page="include/homeHeader.jsp"></jsp:include>
    <jsp:include page="include/homeContent.jsp"></jsp:include>
    <jsp:include page="include/homeFooter.jsp"></jsp:include>

    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

    <sec:authorize access="isAuthenticated()">
        <div id="chat-icon">
            <img src="<c:url value='/Frontend/img/chat.png' />" alt="Chat Icon" title="Chat với Admin">
        </div>

        <div id="chat-container" style="display: none;">
            <div id="chat-header">
                <h3>Chat với Admin</h3>
                <button id="close-chat">×</button>
            </div>
            <div id="chat-box">
                <div id="chat-conversation">
                    <div id="messages"></div>
                    <div class="input-container">
                        <input type="text" id="message-input"
                               placeholder="Nhập tin nhắn của bạn..."
                               onkeypress="if(event.keyCode==13) sendMessage()">
                        <button onclick="sendMessage()">Gửi</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
        <script src="<c:url value='/js/chat.js' />" defer></script>
    </sec:authorize>

    <!-- AI Chatbot floating button (visible to all) -->
    <div id="ai-chatbot-icon">
        <img src="<c:url value='/Frontend/img/chat.png' />" alt="Chatbot" title="Chatbot AI">
    </div>

    <div id="ai-chatbot-panel" style="display: none;">
        <div class="ai-header">
            <strong>Chatbot tư vấn</strong>
            <button id="ai-chatbot-close">×</button>
        </div>
        <div class="ai-body">
            <div id="ai-chatbot-hint">Hỏi bất cứ điều gì về sản phẩm. Ví dụ: "Laptop tầm 20 triệu?", "Điện thoại chụp ảnh đẹp dưới 10 triệu?"</div>
            <div id="ai-chatbot-answer"></div>
        </div>
        <div class="ai-input">
            <input id="ai-chatbot-input" type="text" placeholder="Nhập câu hỏi..." />
            <button id="ai-chatbot-send">Hỏi</button>
        </div>
    </div>

    <script src="<c:url value='/js/client/chatbot.js' />"></script>
    <script>
        (function(){
            var icon = document.getElementById('ai-chatbot-icon');
            var panel = document.getElementById('ai-chatbot-panel');
            var closeBtn = document.getElementById('ai-chatbot-close');
            var sendBtn = document.getElementById('ai-chatbot-send');
            var input = document.getElementById('ai-chatbot-input');
            var answerEl = document.getElementById('ai-chatbot-answer');

            if (!icon || !panel) return;

            function openPanel(){ panel.style.display = 'block'; input && input.focus && input.focus(); }
            function closePanel(){ panel.style.display = 'none'; }

            icon.addEventListener('click', function(){
                if (panel.style.display === 'none' || panel.style.display === '') openPanel(); else closePanel();
            });
            if (closeBtn) closeBtn.addEventListener('click', closePanel);

            async function doAsk(){
                var q = (input && input.value ? input.value.trim() : '');
                if (!q) return;
                answerEl.textContent = 'Đang soạn câu trả lời...';
                var res = await (window.askChatbot ? window.askChatbot(q) : Promise.resolve('Không thể gọi chatbot.'));
                answerEl.textContent = res || 'Không có phản hồi.';
            }
            if (sendBtn) sendBtn.addEventListener('click', doAsk);
            if (input) input.addEventListener('keypress', function(e){ if (e.key === 'Enter') doAsk(); });
        })();
    </script>
</body>
</html>