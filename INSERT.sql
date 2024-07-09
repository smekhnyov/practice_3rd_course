-- Insert test data into Projects
INSERT INTO "Projects" ("ProjectName") VALUES 
('Project Alpha'),
('Project Beta');

-- Insert test data into Positions
INSERT INTO "Positions" ("PositionName") VALUES 
('Developer'),
('Tester'),
('Project Manager'),
('User'),
('Client');

-- Insert test data into Employees
INSERT INTO "Employees" ("FirstName", "LastName", "MiddleName", "PositionID") VALUES 
('John', 'Doe', 'A', 1),
('Jane', 'Smith', 'B', 2),
('Alice', 'Johnson', 'C', 3);

-- Insert test data into Priorities
INSERT INTO "Priorities" ("PriorityName", "PriorityColor") VALUES 
('Critical', 'Red'),
('High', 'Orange'),
('Medium', 'Yellow'),
('Low', 'Green'),
('Pending', 'Blue'),
('Unknown', 'White');

-- Insert test data into Types
INSERT INTO "Types" ("TypeName") VALUES 
('Logic'),
('UI'),
('DB');

-- Insert test data into Defects
INSERT INTO "Defects" ("DefectName", "ShortDescription", "DetailedDescription", "DateDiscovered", "DiscoveredBy", "ProjectID", "TypeID", "PriorityID", "PlannedFixTime", "ActualFixTime", "IsFixed") VALUES 
('Null Pointer Exception', 'App crashes when clicking save', 'The application crashes due to a null pointer dereference when clicking the save button.', '2023-07-01 10:00:00+00', 1, 1, 1, 1, '2023-07-05 10:00:00+00', NULL, false),
('Login Page Enhancement', 'Add remember me feature', 'Implement a checkbox on the login page to remember user credentials.', '2023-07-02 11:00:00+00', 2, 2, 2, 2, '2023-07-10 10:00:00+00', NULL, false);

-- Insert test data into Comments
INSERT INTO "Comments" ("DefectID", "CommentText", "CommentedBy", "CommentTime") VALUES 
(1, 'This issue occurs intermittently.', 2, '2023-07-01 11:00:00+00'),
(2, 'This feature will greatly enhance user experience.', 3, '2023-07-02 12:00:00+00');

-- Insert test data into Statuses
INSERT INTO "Statuses" ("StatusName") VALUES 
('Open'),
('In Progress'),
('Closed'),
('Pending'),
('Blocked');

-- Insert test data into DefectStatusHistory
INSERT INTO "DefectStatusHistory" ("DefectID", "StatusID", "DateChanged", "ChangedBy") VALUES 
(1, 1, '2023-07-01 10:30:00+00', 1),
(1, 2, '2023-07-02 09:00:00+00', 2),
(2, 1, '2023-07-02 11:30:00+00', 2);

-- Insert test data into DefectDependencies
INSERT INTO "DefectDependencies" ("DefectID", "DependsOnDefectID") VALUES 
(2, 1);

-- Insert test data into DefectAssignees
INSERT INTO "DefectAssignees" ("DefectID", "AssigneeID", "IsResponsible") VALUES 
(1, 1, true),
(2, 2, true),
(1, 3, false);
