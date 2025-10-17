let stompClient = null;
let currentUser = null;
let currentConversation = null;

document.addEventListener('DOMContentLoaded', function() {
    const chatIcon = document.getElementById('chat-icon');
    if (chatIcon) {
        // Click handler để mở chat box
        chatIcon.addEventListener('click', toggleChatBox);
    }

    // Xử lý nút đóng chat box
    const closeButton = document.getElementById('close-chat');
    if (closeButton) {
        closeButton.addEventListener('click', function(e) {
            e.stopPropagation();
            toggleChatBox();
        });
    }

    // Ngăn sự kiện click lan truyền cho chat container và các phần tử con
    const chatContainer = document.getElementById('chat-container');
    if (chatContainer) {
        chatContainer.addEventListener('click', function(e) {
            e.stopPropagation();
        });

        // Chat list
        const chatList = chatContainer.querySelector('#chat-list');
        if (chatList) {
            chatList.addEventListener('click', function(e) {
                e.stopPropagation();
            });
        }

        // Chat conversation
        const chatConversation = chatContainer.querySelector('#chat-conversation');
        if (chatConversation) {
            chatConversation.addEventListener('click', function(e) {
                e.stopPropagation();
            });
        }

        // Input container
        const inputContainer = chatContainer.querySelector('.input-container');
        if (inputContainer) {
            inputContainer.addEventListener('click', function(e) {
                e.stopPropagation();
            });
        }

        // Message input
        const messageInput = chatContainer.querySelector('#message-input');
        if (messageInput) {
            messageInput.addEventListener('click', function(e) {
                e.stopPropagation();
            });
        }
    }
});

function toggleChatBox() {
    const chatContainer = document.getElementById('chat-container');
    const chatIcon = document.getElementById('chat-icon');

    if (!chatContainer || !chatIcon) return;

    if (chatContainer.style.display === 'none' || chatContainer.style.display === '') {
        chatContainer.style.display = 'block';
        chatIcon.style.display = 'none';

        fetch('/mobilestore/api/current-user', { credentials: 'include' })
            .then(response => response.json())
            .then(data => {
                currentUser = data.username;
                if (data.role === 'ROLE_ADMIN') {
                    loadMessageList();
                } else {
                    // Nếu là user thường, tải lịch sử tin nhắn
                    loadUserMessageHistory();
                }
                if (!stompClient) {
                    connect();
                }
            })
            .catch(error => {
                console.error('Error:', error);
                chatContainer.style.display = 'none';
                chatIcon.style.display = 'flex';
            });
    } else {
        chatContainer.style.display = 'none';
        chatIcon.style.display = 'flex';
    }
}

// function loadMessageList() {
//     const chatList = document.getElementById('chat-list');
//     if (!chatList) return;
//
//     fetch('/mobilestore/messages/latest')
//         .then(response => response.json())
//         .then(messages => {
//             const messageMap = {};
//             messages.forEach(msg => {
//                 if (!messageMap[msg.fromUser] ||
//                     new Date(msg.timestamp) > new Date(messageMap[msg.fromUser].timestamp)) {
//                     messageMap[msg.fromUser] = msg;
//                 }
//             });
//
//             chatList.innerHTML = '';
//             Object.entries(messageMap).forEach(([email, msg]) => {
//                 const time = new Date(msg.timestamp).toLocaleTimeString();
//                 chatList.innerHTML += `
//                     <div class="chat-item" onclick="openConversation('${email}')">
//                         <h4>${email}</h4>
//                         <p>${msg.content}</p>
//                         <small>${time}</small>
//                     </div>
//                 `;
//             });
//             chatList.style.display = 'block';
//         })
//         .catch(error => console.error('Error:', error));
// }

function loadMessageList() {
    const chatList = document.getElementById('chat-list');
    if (!chatList) return;

    fetch('/mobilestore/messages/latest')
        .then(response => response.json())
        .then(messages => {
            const messageMap = {};
            messages.forEach(msg => {
                if (!messageMap[msg.fromUser] ||
                    new Date(msg.timestamp) > new Date(messageMap[msg.fromUser].timestamp)) {
                    messageMap[msg.fromUser] = msg;
                }
            });

            chatList.innerHTML = '';
            Object.entries(messageMap).forEach(([email, msg]) => {
                const time = new Date(msg.timestamp).toLocaleTimeString();
                fetch(`/mobilestore/api/tai-khoan/email/${email}`)
                    .then(response => response.json())
                    .then(userData => {
                        chatList.innerHTML += `
                            <div class="chat-item" onclick="openConversation('${email}')">
                                <div class="chat-header">
                                    <h4>${userData.hoTen || email}</h4>
                                    <small class="email">${email}</small>
                                </div>
                                <p>${msg.content}</p>
                                <small>${time}</small>
                            </div>
                        `;
                    })
                    .catch(() => {
                        chatList.innerHTML += `
                            <div class="chat-item" onclick="openConversation('${email}')">
                                <div class="chat-header">
                                    <h4>${email}</h4>
                                    <small class="email">${email}</small>
                                </div>
                                <p>${msg.content}</p>
                                <small>${time}</small>
                            </div>
                        `;
                    });
            });
            chatList.style.display = 'block';
        })
        .catch(error => console.error('Error:', error));
}

function loadUserMessageHistory() {
    const messages = document.getElementById('messages');
    if (!messages) return;

    fetch('/mobilestore/messages/user')
        .then(response => response.json())
        .then(messagesData => {
            console.log('Loading user message history:', messagesData);
            messages.innerHTML = '';

            messagesData.forEach(msg => {
                const isCurrentUser = msg.fromUser === currentUser;
                const time = new Date(msg.timestamp).toLocaleTimeString();
                const messageHtml = `
                    <div class="message ${isCurrentUser ? 'sent' : 'received'}">
                        <div class="message-content">
                            <div class="message-text">${msg.content}</div>
                            <div class="message-time">${time}</div>
                        </div>
                    </div>
                `;
                messages.innerHTML += messageHtml;
            });

            messages.scrollTop = messages.scrollHeight;
        })
        .catch(error => {
            console.error('Error loading user message history:', error);
            messages.innerHTML = '<div class="error">Không thể tải lịch sử tin nhắn</div>';
        });
}

function openConversation(userEmail) {
    const chatList = document.getElementById('chat-list');
    const chatConversation = document.getElementById('chat-conversation');
    const messages = document.getElementById('messages');
    const backButton = document.getElementById('back-button');
    const messageInput = document.getElementById('message-input');

    if (!chatList || !chatConversation || !messages) return;

    chatList.style.display = 'none';
    chatConversation.style.display = 'block';
    if (backButton) backButton.style.display = 'block';
    currentConversation = userEmail;

    console.log('Opening conversation with:', userEmail);

    fetch(`/mobilestore/messages/conversation?userEmail=${userEmail}`)
        .then(response => response.json())
        .then(messagesData => {
            console.log('Received messages:', messagesData);
            messages.innerHTML = '';

            messagesData.forEach(msg => {
                const isCurrentUser = msg.fromUser === currentUser;
                const time = new Date(msg.timestamp).toLocaleTimeString();
                const messageHtml = `
                    <div class="message ${isCurrentUser ? 'sent' : 'received'}">
                        <div class="message-content">
                            <div class="message-text">${msg.content}</div>
                            <div class="message-time">${time}</div>
                        </div>
                    </div>
                `;
                messages.innerHTML += messageHtml;
            });

            messages.scrollTop = messages.scrollHeight;
            if (messageInput) messageInput.focus();
        })
        .catch(error => {
            console.error('Error loading conversation:', error);
            messages.innerHTML = '<div class="error">Không thể tải tin nhắn</div>';
        });
}

// Thêm biến để lưu tin nhắn realtime
window.realtimeMessages = {};

// Hàm helper để thêm tin nhắn vào chat
function addMessageToChat(msgData, messages) {
    const time = new Date(msgData.timestamp).toLocaleTimeString();
    messages.innerHTML += `
        <div class="message received">
            <div class="message-content">
                <div class="message-text">${msgData.content}</div>
                <div class="message-time">${time}</div>
            </div>
        </div>
    `;
    messages.scrollTop = messages.scrollHeight;
}

// Cập nhật hàm connect để xử lý đúng subscription cho member
function connect() {
    const socket = new SockJS('/mobilestore/chat');
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function(frame) {
        console.log('Connected:', frame);
        fetch('/mobilestore/api/current-user', { credentials: 'include' })
            .then(response => response.json())
            .then(data => {
                currentUser = data.username;
                console.log('Current user:', currentUser, 'Role:', data.role);

                // Chỉ subscribe queue riêng cho cả admin và member
                stompClient.subscribe(`/user/${currentUser}/queue/messages`, handleNewMessage);

                if (data.role === 'ROLE_ADMIN') {
                    loadMessageList();
                } else {
                    // Nếu là user thường, tải lịch sử tin nhắn
                    loadUserMessageHistory();
                }
            });
    });
}

function handleNewMessage(message) {
    const msgData = JSON.parse(message.body);
    console.log('Received new message:', msgData);

    // Nếu người dùng hiện tại là người gửi, không xử lý
    if (msgData.fromUser === currentUser) return;

    const messages = document.getElementById('messages');
    const chatList = document.getElementById('chat-list');

    // Nếu đang trong chat box
    if (messages) {
        // Nếu là admin đang chat với member
        if (chatList && currentConversation === msgData.fromUser) {
            addMessageToChat(msgData, messages);
        }
        // Nếu là member nhận tin nhắn từ admin
        else if (!chatList && msgData.toUser === currentUser) {
            addMessageToChat(msgData, messages);
        }
        // Nếu là user thường và nhận tin nhắn từ admin
        else if (!chatList && msgData.fromUser !== currentUser) {
            addMessageToChat(msgData, messages);
        }
    }

    // Nếu là admin và đang ở màn hình chat list
    if (chatList && chatList.style.display === 'block') {
        loadMessageList();
    }
}

function goBack() {
    const chatList = document.getElementById('chat-list');
    const chatConversation = document.getElementById('chat-conversation');
    const backButton = document.getElementById('back-button');

    if (!chatList || !chatConversation) return;

    chatList.style.display = 'block';
    chatConversation.style.display = 'none';
    if (backButton) backButton.style.display = 'none';
    currentConversation = null;
    loadMessageList();
}

function sendMessage() {
    const messageInput = document.getElementById('message-input');
    if (!messageInput || !messageInput.value.trim()) return;

    if (!stompClient) {
        alert('Chưa kết nối chat!');
        return;
    }

    fetch('/mobilestore/api/current-user', { credentials: 'include' })
        .then(response => response.json())
        .then(data => {
            const chatMessage = {
                fromUser: data.username,
                toUser: data.role === 'ROLE_ADMIN' ? currentConversation : '',
                content: messageInput.value.trim(),
                timestamp: new Date().toISOString()
            };

            stompClient.send("/app/sendMessage", {}, JSON.stringify(chatMessage));

            const messages = document.getElementById('messages');
            if (messages) {
                const time = new Date().toLocaleTimeString();
                messages.innerHTML += `
                    <div class="message sent">
                        <div class="message-content">
                            <div class="message-text">${chatMessage.content}</div>
                            <div class="message-time">${time}</div>
                        </div>
                    </div>
                `;
                messages.scrollTop = messages.scrollHeight;
            }

            messageInput.value = '';
            messageInput.focus();
        })
        .catch(error => console.error('Error:', error));
}