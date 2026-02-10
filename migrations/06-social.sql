-- 5.7 Social
-- Said, Grupp 1

-- 5.7.1: skicka meddelanden mellan användare
-- 5.7.2: parent_id för trådar, NULL = ny tråd
CREATE TABLE messages (
    messages_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    parent_id INT DEFAULT NULL,
    body TEXT NOT NULL,
    FOREIGN KEY (sender_id) REFERENCES users (users_id),
    FOREIGN KEY (receiver_id) REFERENCES users (users_id),
    FOREIGN KEY (parent_id) REFERENCES messages (messages_id)
);

-- Testdata messages
INSERT INTO messages (sender_id, receiver_id, parent_id, body) VALUES
(1, 2, NULL, 'Hej! Hur mår din hund?'),
(2, 1, 1, 'Bra! Han älskar den nya maten.'),
(1, 2, 2, 'Vilken sort köpte du?'),
(4, 1, NULL, 'Säljer du fortfarande kattleksaker?'),
(1, 4, 4, 'Ja, kolla shoppen!');
