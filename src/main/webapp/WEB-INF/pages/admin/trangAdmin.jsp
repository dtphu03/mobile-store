<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
    <!DOCTYPE html>
    <html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang Quản Trị</title>
        <link rel="stylesheet" href="<c:url value='/Frontend/css/chat.css' />">
    </head>
    <body>
        <jsp:include page="template/header.jsp"></jsp:include>
        <jsp:include page="template/sidebar.jsp"></jsp:include>
        <jsp:include page="template/content.jsp"></jsp:include>
        <jsp:include page="template/footer.jsp"></jsp:include>

        <sec:authorize access="hasRole('ROLE_ADMIN')">
<%--            <div id="chat-icon" onclick="toggleChatBox()">--%>
            <div id="chat-icon">
                <img src="<c:url value='/Frontend/img/chat.png' />" alt="Chat Icon">
            </div>

            <div id="chat-container" style="display: none;">
                <div id="chat-header">
                    <h3>Tin nhắn khách hàng</h3>
                    <button id="close-chat">×</button>
                </div>

                <div id="chat-box">
                    <!-- Danh sách chat -->
                    <div id="chat-list"></div>

                    <!-- Khung chat -->
                    <div id="chat-conversation" style="display: none;">
                        <div class="conversation-header">
                            <button id="back-button" onclick="goBack()">
                                <span class="back-icon">←</span>
                                <span>Quay lại</span>
                            </button>
                        </div>

                        <div id="messages" class="messages-container"></div>

                        <div class="input-container">
                            <input type="text" id="message-input"
                                   placeholder="Nhập tin nhắn..."
                                   onkeypress="if(event.keyCode==13) sendMessage()">
                            <button onclick="sendMessage()">Gửi</button>
                        </div>
                    </div>
                </div>
            </div>
        </sec:authorize>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
        <script src="<c:url value='/js/chat.js' />" defer></script>
    </body>
    </html>