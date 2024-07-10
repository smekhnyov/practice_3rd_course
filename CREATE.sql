DROP TABLE IF EXISTS Defects CASCADE;
DROP TABLE IF EXISTS Projects CASCADE;
DROP TABLE IF EXISTS Employees CASCADE;
DROP TABLE IF EXISTS DefectTypes CASCADE;
DROP TABLE IF EXISTS Comments CASCADE;
DROP TABLE IF EXISTS DefectStatusHistory CASCADE;
DROP TABLE IF EXISTS Statuses CASCADE;
DROP TABLE IF EXISTS Priorities CASCADE;
DROP TABLE IF EXISTS DefectDependencies CASCADE;
DROP TABLE IF EXISTS DefectAssignees CASCADE;
DROP TABLE IF EXISTS Positions CASCADE;
DROP TABLE IF EXISTS PositionTypes CASCADE;

CREATE TABLE IF NOT EXISTS Defects (
	DefectID serial NOT NULL UNIQUE,
	DefectName text NOT NULL,
	ShortDescription text NOT NULL,
	DetailedDescription text,
	DateDiscovered timestamp with time zone NOT NULL,
	DiscoveredBy bigint NOT NULL,
	ProjectID bigint NOT NULL,
	TypeID bigint NOT NULL,
	PriorityID bigint NOT NULL,
	PlannedFixTime timestamp with time zone,
	ActualFixTime timestamp with time zone,
	IsFixed boolean NOT NULL,
	PRIMARY KEY (DefectID)
);

CREATE TABLE IF NOT EXISTS Projects (
	ProjectID serial NOT NULL UNIQUE,
	ProjectName text NOT NULL,
	PRIMARY KEY (ProjectID)
);

CREATE TABLE IF NOT EXISTS Employees (
	EmployeeID serial NOT NULL UNIQUE,
	FirstName text NOT NULL,
	LastName text NOT NULL,
	MiddleName text,
	PositionID bigint NOT NULL,
	PRIMARY KEY (EmployeeID)
);

CREATE TABLE IF NOT EXISTS Positions (
	PositionID serial NOT NULL UNIQUE,
	PositionName text NOT NULL,
	PRIMARY KEY (PositionID)
);

CREATE TABLE IF NOT EXISTS Priorities (
	PriorityID serial NOT NULL UNIQUE,
	PriorityName text NOT NULL,
	PriorityColor text NOT NULL,
	PRIMARY KEY (PriorityID)
);

CREATE TABLE IF NOT EXISTS DefectTypes (
	TypeID serial NOT NULL UNIQUE,
	TypeName text NOT NULL,
	PRIMARY KEY (TypeID)
);

CREATE TABLE IF NOT EXISTS Comments (
	CommentID serial NOT NULL UNIQUE,
	DefectID bigint NOT NULL,
	CommentText text NOT NULL,
	CommentedBy bigint NOT NULL,
	CommentTime timestamp with time zone NOT NULL,
	PRIMARY KEY (CommentID)
);

CREATE TABLE IF NOT EXISTS DefectStatusHistory (
	HistoryID serial NOT NULL UNIQUE,
	DefectID bigint NOT NULL,
	StatusID bigint NOT NULL,
	DateChanged timestamp with time zone NOT NULL,
	ChangedBy bigint NOT NULL,
	PRIMARY KEY (HistoryID)
);

CREATE TABLE IF NOT EXISTS Statuses (
	StatusID serial NOT NULL UNIQUE,
	StatusName text NOT NULL,
	PRIMARY KEY (StatusID)
);

CREATE TABLE IF NOT EXISTS DefectDependencies (
	DefectID serial NOT NULL,
	DependsOnDefectID bigint NOT NULL,
	PRIMARY KEY (DefectID, DependsOnDefectID)
);

CREATE TABLE IF NOT EXISTS DefectAssignees (
	DefectID serial NOT NULL,
	AssigneeID bigint NOT NULL,
	IsResponsible boolean NOT NULL,
	PRIMARY KEY (DefectID, AssigneeID)
);

ALTER TABLE Defects ADD CONSTRAINT Defects_fk5 FOREIGN KEY (DiscoveredBy) REFERENCES Employees(EmployeeID);

ALTER TABLE Defects ADD CONSTRAINT Defects_fk6 FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID);

ALTER TABLE Defects ADD CONSTRAINT Defects_fk7 FOREIGN KEY (TypeID) REFERENCES Types(TypeID);

ALTER TABLE Defects ADD CONSTRAINT Defects_fk8 FOREIGN KEY (PriorityID) REFERENCES Priorities(PriorityID);


ALTER TABLE Employees ADD CONSTRAINT Employees_fk0 FOREIGN KEY (PositionID) REFERENCES Positions(PositionID);

ALTER TABLE Comments ADD CONSTRAINT Comments_fk1 FOREIGN KEY (DefectID) REFERENCES Defects(DefectID);

ALTER TABLE Comments ADD CONSTRAINT Comments_fk3 FOREIGN KEY (CommentedBy) REFERENCES Employees(EmployeeID);
ALTER TABLE DefectStatusHistory ADD CONSTRAINT DefectStatusHistory_fk1 FOREIGN KEY (DefectID) REFERENCES Defects(DefectID);

ALTER TABLE DefectStatusHistory ADD CONSTRAINT DefectStatusHistory_fk2 FOREIGN KEY (StatusID) REFERENCES Statuses(StatusID);

ALTER TABLE DefectStatusHistory ADD CONSTRAINT DefectStatusHistory_fk4 FOREIGN KEY (ChangedBy) REFERENCES Employees(EmployeeID);

ALTER TABLE DefectDependencies ADD CONSTRAINT DefectDependencies_fk0 FOREIGN KEY (DefectID) REFERENCES Defects(DefectID);

ALTER TABLE DefectDependencies ADD CONSTRAINT DefectDependencies_fk1 FOREIGN KEY (DependsOnDefectID) REFERENCES Defects(DefectID);
ALTER TABLE DefectAssignees ADD CONSTRAINT DefectAssignees_fk0 FOREIGN KEY (DefectID) REFERENCES Defects(DefectID);

ALTER TABLE DefectAssignees ADD CONSTRAINT DefectAssignees_fk1 FOREIGN KEY (AssigneeID) REFERENCES Employees(EmployeeID);
