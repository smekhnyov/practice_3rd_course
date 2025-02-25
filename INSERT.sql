INSERT INTO Projects (ProjectName) VALUES 
('Project Alpha'),
('Project Beta'),
('Project Gamma'),
('Project Shtrih'),
('Project Sigma');

INSERT INTO Positions (PositionName) VALUES 
('Developer'),
('Tester'),
('Project Manager'),
('User'),
('Client');

INSERT INTO Employees (FirstName, LastName, MiddleName, PositionID) VALUES 
('Всеволод', 'Брянцев', 'Александрович', 1),
('Иван', 'Смехнев', 'Юрьевич', 1),
('Дмитрий', 'Оболонский', 'Юрьевич', 3),
('Павел', 'Носков', 'Эдуардович', 2),
('Леонид', 'Мазуров', 'Алексеевич', 4),
('Святослав', 'Шумейко', 'Евгеньевич', 4),
('Павел', 'Недобежкин', 'Владимирович', 5),
('Ибрагим', 'Айбайльдульчевов', 'Махмудович', 5),
('Ян', 'Яшин-Няшин', 'Янович', 5),
('Азамат', 'Простинин-Извининин', 'Алмазович', 2),
('Владислав', 'Брянцев', 'Александрович', 5),
('Азамат', 'Простипжев', 'Ахметович', 1);

INSERT INTO Priorities (PriorityName, PriorityColor) VALUES 
('Critical', 'Red'),
('High', 'Orange'),
('Medium', 'Yellow'),
('Low', 'Green'),
('Pending', 'Blue'),
('Unknown', 'White');

INSERT INTO DefectTypes (TypeName) VALUES 
('Logic'),
('UI'),
('DB');

INSERT INTO Defects (DefectName, ShortDescription, DetailedDescription, DateDiscovered, DiscoveredBy, ProjectID, TypeID, PriorityID, PlannedFixTime, ActualFixTime, IsFixed) VALUES 
('Null Pointer Exception', 'App crashes when clicking save', 'The application crashes due to a null pointer dereference when clicking the save button.', '2017-07-01 10:00:00+00', 1, 1, 1, 1, '2017-07-05 10:00:00+00', NULL, false),
('Login Page Enhancement', 'Add remember me feature', 'Implement a checkbox on the login page to remember user credentials.', '2017-08-12 11:11:00+00', 2, 2, 2, 5, '2017-08-20 10:00:00+00', '2017-08-19 09:13:56+00', true),
('Memory Leak in Module X', 'App slows down over time', 'The application experiences a memory leak in module X, causing it to slow down progressively.', '2017-10-03 01:31:00+00', 2, 1, 1, 1, '2017-10-04 10:00:00+00', '2017-10-05 11:59:54+00', true),
('UI Overlap on Dashboard', 'UI elements overlap', 'UI elements on the dashboard overlap when the window is resized to a smaller width.', '2017-12-31 14:15:00+00', 4, 1, 2, 4, '2018-01-01 14:15:00+00', NULL, false),
('Database Connection Timeout', 'Timeout errors on queries', 'Database queries intermittently fail due to connection timeout errors.', '2018-01-02 16:45:00+00', 5, 3, 3, 3, '2018-01-08 16:45:00+00', NULL, false),
('Incorrect Total Calculation', 'Total amount incorrect', 'The total amount is incorrectly calculated in the invoice module under certain conditions.', '2018-02-01 10:30:00+00', 1, 4, 1, 2, '2018-02-09 10:30:00+00', '2018-02-10 07:05:34+00', true),
('Broken Link on Homepage', '404 error on link', 'A hyperlink on the homepage results in a 404 error.', '2018-04-06 13:00:00+00', 10, 2, 1, 2, '2018-04-07 13:00:00+00', '2018-04-07 13:01:00+00', true),
('Slow Response Time on Search', 'Search feature is slow', 'The search feature has a high response time, especially with larger datasets.', '2018-07-07 11:45:00+00', 6, 1, 1, 6, '2018-07-14 11:45:00+00', NULL, false),
('Incorrect Date Format', 'Date format is wrong', 'Dates are displayed in an incorrect format in the user profile section.', '2018-08-08 03:20:00+00', 4, 3, 1, 3, '2018-09-13 09:00:00+00', '2018-10-13 09:00:00+00', true),
('Button Click Not Responding', 'Button does not respond', 'The submit button on the feedback form does not respond on the first click.', '2018-07-09 12:30:00+00', 5, 1, 1, 1, '2018-07-15 12:30:00+00', '2018-08-15 12:30:00+00', true),
('Image Upload Failure', 'Cannot upload images', 'Users are unable to upload images in the gallery section due to a server error.', '2019-01-10 08:00:00+00', 1, 1, 1, 5, '2019-02-16 08:00:00+00', NULL, false),
('Mismatched User Roles', 'Roles not assigned correctly', 'User roles are not assigned correctly after registration, causing access issues.', '2020-07-11 15:15:00+00', 7, 3, 3, 3, '2020-07-18 15:15:00+00', NULL, false),
('API Authentication Error', 'API fails to authenticate', 'The API fails to authenticate users intermittently, leading to failed API calls.', '2021-07-12 14:00:00+00', 8, 2, 3, 3, '2021-07-19 14:00:00+00', '2021-07-20 14:00:00+00', true),
('Alignment Issue on Settings Page', 'Misaligned text', 'Text fields and labels are misaligned on the settings page.', '2023-07-13 10:20:00+00', 4, 1, 2, 4, '2023-07-20 10:20:00+00', NULL, false),
('Missing Translations in French', 'Missing translations', 'Some sections of the application lack French translations.', '2023-07-14 11:00:00+00', 5, 4, 1, 5, '2023-07-21 11:00:00+00', NULL, false),
('Security Vulnerability in Login', 'Vulnerability detected', 'A security vulnerability was detected in the login module, allowing potential unauthorized access.', '2024-01-10 10:00:00+00', 9, 2, 3, 1, '2024-01-20 10:00:00+00', NULL, false),
('Performance Degradation in Reports', 'Reports load slowly', 'Report generation is significantly slower after the latest update.', '2024-02-15 11:00:00+00', 3, 1, 1, 2, '2024-02-20 11:00:00+00', '2024-02-21 12:00:00+00', true),
('Incorrect Error Messages', 'Misleading error messages', 'Error messages displayed to users are misleading and incorrect.', '2024-03-20 14:00:00+00', 6, 2, 2, 3, '2024-03-25 14:00:00+00', '2024-03-26 15:00:00+00', true),
('Data Sync Failure', 'Data not syncing properly', 'Data between the local application and the server is not syncing correctly.', '2024-04-22 09:00:00+00', 2, 4, 3, 4, '2024-04-30 09:00:00+00', NULL, false),
('User Interface Glitch', 'UI glitch on profile page', 'A glitch occurs on the user profile page when editing details.', '2024-05-18 16:00:00+00', 7, 3, 2, 5, '2024-05-25 16:00:00+00', '2024-05-26 17:00:00+00', true),
('Session Timeout Issue', 'User session times out too quickly', 'The user session times out after a short period of inactivity, causing inconvenience.', '2024-06-12 10:30:00+00', 2, 1, 1, 4, '2024-07-10 10:30:00+00', NULL, false),
('Broken Footer Links', 'Footer links are broken', 'Several links in the footer are broken and lead to 404 errors.', '2024-06-13 14:00:00+00', 1, 2, 2, 3, '2024-06-15 14:00:00+00', NULL, false),
('Incorrect User Data', 'User data displayed incorrectly', 'Some user data fields are displayed incorrectly on the profile page.', '2024-06-15 09:45:00+00', 2, 3, 2, 2, '2024-06-20 09:45:00+00', NULL, false),
('Performance Degradation', 'App performance degrades over time', 'The application performance degrades after prolonged usage, affecting user experience.', '2024-06-20 16:00:00+00', 1, 1, 1, 5, '2024-06-25 16:00:00+00', NULL, false),
('Email Notifications Not Sent', 'Email notifications are not being sent', 'Users are not receiving email notifications for important events.', '2024-06-25 11:30:00+00', 2, 2, 3, 1, '2024-06-30 11:30:00+00', NULL, false),
('UI Color Issue', 'Color inconsistency in UI', 'Some buttons have incorrect colors in the UI.', '2024-07-05 10:00:00+00', 1, 1, 2, 1, '2024-07-07 10:00:00+00', '2024-07-08 10:00:00+00', true),
('Performance Drop on Dashboard', 'Dashboard loading slowly', 'The dashboard loads significantly slower than usual.', '2024-07-10 11:00:00+00', 1, 2, 1, 2, '2024-07-12 11:00:00+00', NULL, false),
('API Integration Failure', 'Integration with API not working', 'The application fails to integrate with the external API.', '2024-07-11 10:00:00+00', 2, 3, 3, 3, '2024-07-20 12:00:00+00', NULL, false);

INSERT INTO Comments (DefectID, CommentText, CommentedBy, CommentTime) VALUES 
(1, 'This issue occurs intermittently.', 2, '2023-07-01 11:00:00+00'),
(2, 'This feature will greatly enhance #user experience.', 3, '2023-07-02 12:00:00+00'),
(3, 'Memory leak seems to occur after prolonged usage.', 4, '2017-10-03 10:00:00+00'),
(4, 'This issue is critical for smaller screen sizes.', 5, '2017-12-31 15:00:00+00'),
(5, 'Database connection timeout is affecting multiple #users.', 1, '2018-01-03 17:00:00+00'),
(6, 'Incorrect total calculation occurs sporadically.', 2, '2018-02-01 11:00:00+00'),
(7, 'Broken link has been fixed in the latest update.', 3, '2018-04-06 14:00:00+00'),
(8, 'Search performance needs optimization.', 4, '2018-07-07 12:00:00+00'),
(9, 'Date format issue reported by multiple #users.', 5, '2018-08-08 10:00:00+00'),
(10, 'Feedback form button needs immediate attention.', 6, '2018-07-09 13:00:00+00'),
(11, 'Image upload error might be server-related.', 1, '2019-01-10 09:00:00+00'),
(12, '#User roles mismatch needs urgent fix.', 2, '2020-07-11 16:00:00+00'),
(13, 'API authentication error frequency has increased.', 3, '2021-07-12 15:00:00+00'),
(14, 'Settings page alignment is a minor issue.', 4, '2023-07-13 11:00:00+00'),
(15, 'Missing French translations need to be added.', 5, '2023-07-14 12:00:00+00'),
(1, 'Crash occurs when save button is clicked rapidly.', 3, '2017-07-01 12:00:00+00'),
(2, 'Remember me feature is a priority for #users.', 4, '2017-08-12 12:11:00+00'),
(3, 'Memory leak detected in recent logs.', 5, '2017-10-03 11:00:00+00'),
(4, 'Dashboard $UI overlap affects usability.', 1, '2017-12-31 16:00:00+00'),
(5, 'Timeout errors occur during peak hours.', 2, '2018-01-02 17:45:00+00'),
(6, 'Incorrect total calculation needs a quick fix.', 3, '2018-02-01 12:30:00+00'),
(7, '404 error on homepage link resolved quickly.', 4, '2018-04-06 15:00:00+00'),
(16, 'Security vulnerability needs immediate attention.', 9, '2024-01-10 11:00:00+00'),
(16, 'Potential risk of unauthorized access.', 7, '2024-01-11 12:00:00+00'),
(17, 'Report generation speed has improved slightly.', 3, '2024-02-16 13:00:00+00'),
(17, 'Further optimization required for large datasets.', 4, '2024-02-17 14:00:00+00'),
(18, 'Misleading error messages cause confusion.', 6, '2024-03-20 15:00:00+00'),
(18, 'Error messages need to be more descriptive.', 8, '2024-03-21 16:00:00+00'),
(19, 'Data sync failure needs urgent fix.', 2, '2024-04-22 10:00:00+00'),
(19, 'Sync issues reported by multiple #users.', 5, '2024-04-23 11:00:00+00'),
(20, '$UI glitch is minor but noticeable.', 7, '2024-05-18 17:00:00+00'),
(20, '#User interface needs better testing.', 1, '2024-05-19 18:00:00+00');


INSERT INTO Statuses (StatusName) VALUES 
('Open'),
('In Progress'),
('Closed'),
('Pending'),
('Blocked');

INSERT INTO DefectStatusHistory (DefectID, StatusID, DateChanged, ChangedBy) VALUES 
(1, 3, '2023-07-05 11:00:00+00', 1),
(2, 2, '2023-07-05 12:00:00+00', 2),
(2, 3, '2023-08-01 11:00:00+00', 2),
(3, 1, '2017-10-03 09:45:00+00', 2),
(3, 2, '2017-10-04 10:45:00+00', 3),
(3, 3, '2017-10-05 12:00:00+00', 2),
(4, 1, '2017-12-31 14:30:00+00', 4),
(4, 2, '2018-01-01 13:00:00+00', 5),
(5, 1, '2018-01-02 17:00:00+00', 5),
(5, 2, '2018-01-05 17:00:00+00', 1),
(6, 1, '2018-02-01 11:00:00+00', 1),
(6, 2, '2018-02-08 11:00:00+00', 2),
(6, 3, '2018-02-10 08:00:00+00', 1),
(7, 1, '2018-04-06 13:15:00+00', 10),
(7, 2, '2018-04-07 10:00:00+00', 1),
(7, 3, '2018-04-07 13:10:00+00', 10),
(8, 1, '2018-07-07 12:00:00+00', 6),
(8, 2, '2018-07-10 12:00:00+00', 4),
(9, 1, '2018-08-08 10:00:00+00', 4),
(9, 2, '2018-09-01 10:00:00+00', 5),
(9, 3, '2018-10-13 09:15:00+00', 4),
(10, 1, '2018-07-09 13:00:00+00', 5),
(10, 2, '2018-07-12 13:00:00+00', 1),
(10, 3, '2018-08-15 13:00:00+00', 5),
(11, 1, '2019-01-10 09:00:00+00', 1),
(11, 2, '2019-02-01 09:00:00+00', 1),
(12, 1, '2020-07-11 15:30:00+00', 7),
(12, 2, '2020-07-15 15:30:00+00', 2),
(13, 1, '2021-07-12 14:30:00+00', 8),
(13, 2, '2021-07-18 14:30:00+00', 3),
(13, 3, '2021-07-20 14:15:00+00', 8),
(14, 1, '2023-07-13 10:30:00+00', 4),
(14, 2, '2023-07-18 10:30:00+00', 5),
(15, 1, '2023-07-14 11:15:00+00', 5),
(15, 2, '2023-07-20 11:15:00+00', 4),
(16, 1, '2024-01-05 10:00:00+00', 7),
(16, 2, '2024-01-07 10:00:00+00', 9),
(16, 3, '2024-01-10 10:00:00+00', 7),
(17, 1, '2024-02-12 09:00:00+00', 3),
(17, 2, '2024-02-14 09:00:00+00', 4),
(17, 3, '2024-02-16 09:00:00+00', 3),
(18, 1, '2024-03-15 15:00:00+00', 8),
(18, 2, '2024-03-18 15:00:00+00', 6),
(18, 3, '2024-03-20 15:00:00+00', 8),
(19, 1, '2024-04-18 11:00:00+00', 5),
(19, 2, '2024-04-20 11:00:00+00', 2),
(19, 3, '2024-04-22 11:00:00+00', 5),
(20, 1, '2024-05-14 13:00:00+00', 7),
(20, 2, '2024-05-16 13:00:00+00', 1),
(20, 3, '2024-05-18 13:00:00+00', 7),
(21, 1, '2024-06-19 14:00:00+00', 3),
(21, 2, '2024-06-21 14:00:00+00', 4),
(21, 3, '2024-06-23 14:00:00+00', 3),
(22, 1, '2024-07-20 10:00:00+00', 8),
(22, 2, '2024-07-22 10:00:00+00', 6),
(22, 3, '2024-07-24 10:00:00+00', 8),
(23, 1, '2024-08-21 09:00:00+00', 5),
(23, 2, '2024-08-23 09:00:00+00', 2),
(23, 3, '2024-08-25 09:00:00+00', 5),
(24, 1, '2024-09-22 15:00:00+00', 7),
(24, 2, '2024-09-24 15:00:00+00', 1),
(24, 3, '2024-09-26 15:00:00+00', 7),
(25, 1, '2024-10-23 11:00:00+00', 3),
(25, 2, '2024-10-25 11:00:00+00', 4),
(25, 3, '2024-10-27 11:00:00+00', 3),
(26, 1, '2024-11-24 13:00:00+00', 8),
(26, 2, '2024-11-26 13:00:00+00', 6),
(26, 3, '2024-11-28 13:00:00+00', 8),
(27, 1, '2024-12-25 14:00:00+00', 5),
(27, 2, '2024-12-27 14:00:00+00', 2),
(27, 3, '2024-12-29 14:00:00+00', 5),
(28, 1, '2025-01-26 10:00:00+00', 7);


INSERT INTO DefectDependencies (DefectID, DependsOnDefectID) VALUES 
(2, 1),
(3, 2),
(4, 3),
(5, 1),
(6, 4),
(8, 7),
(11, 10);


INSERT INTO DefectAssignees (DefectID, AssigneeID, IsResponsible) VALUES 
(3, 1, true),
(3, 2, false),
(4, 1, true),
(4, 4, false),
(5, 1, false),
(5, 2, true),
(6, 1, true),
(6, 3, false),
(7, 2, true),
(7, 4, false),
(8, 1, true),
(8, 2, false),
(9, 3, true),
(9, 1, false),
(10, 1, true),
(10, 4, false),
(11, 2, true),
(11, 4, false),
(12, 3, true),
(12, 1, false),
(16, 1, true), 
(16, 2, false), 
(17, 3, true), 
(17, 1, false), 
(18, 4, true), 
(18, 3, false), 
(19, 2, true), 
(19, 1, false), 
(20, 3, true), 
(20, 2, false); 


INSERT INTO EmployeeProjects (EmployeeID, ProjectID) VALUES
(1, 1),
(2, 1),
(4, 1),
(3, 2),
(12, 2),
(10, 2),
(3, 3),
(1, 3),
(11, 3),
(9, 3),
(5, 4),
(2, 4),
(6, 4),
(7, 4),
(8, 4),
(3, 5);
