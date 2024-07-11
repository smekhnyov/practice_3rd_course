-- 1. Выбрать все данные о приоритетах. Результат отсортировать по названию в лексикографическом порядке.
SELECT * FROM Priorities ORDER BY PriorityName;

-- 2. Выбрать названия видов дефектов. Результат отсортировать в порядке обратном лексикографическому.
SELECT TypeName FROM DefectTypes ORDER BY TypeName DESC;

-- 3. Выбрать фамилии и инициалы руководителей проектов. Результат отсортировать по длине фамилии.
SELECT LastName, LEFT(FirstName, 1) || '.' || LEFT(MiddleName, 1) || '.' AS Initials
FROM Employees 
JOIN Positions ON Employees.PositionID = Positions.PositionID
WHERE PositionName = 'Project Manager'
ORDER BY LENGTH(LastName);

-- 4. Выбрать годы обнаружения дефектов без повторений. Результат отсортировать по убыванию.
SELECT DISTINCT EXTRACT(YEAR FROM DateDiscovered) AS DiscoveryYear 
FROM Defects 
ORDER BY DiscoveryYear DESC;

-- 5. Выбрать названия проектов, состоящие только из латинских букв. 
-- Результат отсортировать: вначале четные id, затем нечетные.
SELECT ProjectName 
FROM Projects 
WHERE ProjectName ~ '^[A-Za-z ]+$'
ORDER BY MOD(ProjectID, 2), ProjectID;

-- 6. Выбрать фамилии, имена, отчества клиентов с двойной фамилией 
-- или с фамилией из 5–7 букв, заканчивающейся на -в или -ов. 
-- Результат отсортировать по фамилии, имени, отчеству в порядке обратном лексикографическому.
SELECT LastName, FirstName, MiddleName
FROM Employees
WHERE PositionID = (SELECT PositionID FROM Positions WHERE PositionName = 'Client')
AND (
    (LastName LIKE '%-%') 
    OR (LENGTH(LastName) BETWEEN 5 AND 7 AND LastName LIKE '%в') 
    OR (LENGTH(LastName) BETWEEN 5 AND 7 AND LastName LIKE '%ов')
)
ORDER BY LastName DESC, FirstName DESC, MiddleName DESC;

-- 7. Выбрать все данные о проблемах, в комментариях к которым 
-- встречаются символы «-», «_», «$», «^», «%», «#».
SELECT DISTINCT D.*
FROM Defects D
JOIN Comments C ON D.DefectID = C.DefectID
WHERE C.CommentText IS NOT NULL
AND C.CommentText ~ '[-_$%^#]';

-- 8. Выбрать все данные о дефектах c id 2, 3, 5, 9, 11, 12. 
-- Результат отсортировать: вначале зафиксированные ночью (00:00 - 06:00), затем все остальные.
SELECT *
FROM Defects
WHERE DefectID IN (2, 3, 5, 9, 11, 12)
ORDER BY 
  CASE 
    WHEN EXTRACT(HOUR FROM DateDiscovered) BETWEEN 0 AND 6 THEN 0  
    ELSE 1
  END,
  DateDiscovered;

-- 9. Выбрать данные о дефектах, на исправление которых отводится от 3 до 10 дней. 
-- Результат отсортировать в порядке убывания срока исправления дефектов.
SELECT *
FROM Defects
WHERE PlannedFixTime - DateDiscovered BETWEEN INTERVAL '3 days' AND INTERVAL '10 days'
ORDER BY PlannedFixTime - DateDiscovered DESC;

-- 10. Выбрать id, описание, дату и время исправления дефектов. 
-- Если дефект зафиксирован клиентом, то в последнем столбце вывести «обратите внимание».
SELECT 
  D.DefectID, 
  D.ShortDescription, 
  D.ActualFixTime,
  CASE 
    WHEN E.PositionID = (SELECT PositionID FROM Positions WHERE PositionName = 'Client') THEN 'обратите внимание'
    ELSE NULL
  END AS ClientNote
FROM Defects D
JOIN Employees E ON D.DiscoveredBy = E.EmployeeID
WHERE D.ActualFixTime IS NOT NULL;

-- 11. Выбрать все данные обо всех руководителях проектов.
SELECT E.*
FROM Employees E
JOIN Positions P ON E.PositionID = P.PositionID
WHERE P.PositionName = 'Project Manager'; 

-- 12. Выбрать дату, когда был зафиксирован первый дефект.
SELECT MIN(DateDiscovered)
FROM Defects;

-- 13. Выбрать фамилию, имя, отчество сотрудника и название его должности. 
-- Результат отсортировать: по фамилии (лексикографически), 
-- по имени и отчеству в порядке обратном лексикографическому.
SELECT 
  E.LastName, 
  E.FirstName, 
  E.MiddleName, 
  P.PositionName
FROM Employees E
JOIN Positions P ON E.PositionID = P.PositionID
ORDER BY E.LastName, E.FirstName DESC, E.MiddleName DESC;

-- 14. Выбрать данные обо всех разработчиках проекта N (значение подставьте сами).
SELECT e.FirstName, e.LastName
FROM Employees e
JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
WHERE ep.ProjectID = 4 AND e.PositionID = (SELECT PositionID FROM Positions WHERE PositionName = 'Developer');

-- 15. Выбрать дату, когда был зафиксирован последний дефект 
-- по проекту N (название проекта подставьте сами).
SELECT MAX(DateDiscovered)
FROM Defects
WHERE ProjectID = (SELECT ProjectID FROM Projects WHERE ProjectID = 2);

-- 16. Выбрать среднее время исправления дефектов.
SELECT AVG(ActualFixTime - DateDiscovered) AS AverageFixTime
FROM Defects
WHERE ActualFixTime IS NOT NULL;

-- 17. Выбрать суммарное время, которое планировалось и которое по факту ушло 
-- на исправление дефектов по конкретному проекту 
-- (название проекта подставьте сами). Учитывать только исправленные дефекты.
SELECT 
  SUM(PlannedFixTime - DateDiscovered) AS TotalPlannedTime,
  SUM(ActualFixTime - DateDiscovered) AS TotalActualTime
FROM Defects
WHERE ProjectID = (SELECT ProjectID FROM Projects WHERE ProjectName = 'Project Alpha')
AND ActualFixTime IS NOT NULL;

-- 18. (Сложный запрос, объединяющий данные из многих таблиц)
SELECT 
  P.ProjectName,
  PM.LastName AS ProjectManagerLastName,
  PM.FirstName AS ProjectManagerFirstName,
  PM.MiddleName AS ProjectManagerMiddleName,
  D.DateDiscovered,
  D.DefectName,
  D.ShortDescription,
  D.DetailedDescription,
  DE.LastName AS DiscoveredByLastName,
  DE.FirstName AS DiscoveredByFirstName,
  DE.MiddleName AS DiscoveredByMiddleName,
  D.PlannedFixTime,
  S.StatusName,
  DSH.DateChanged AS StatusChangeDate,
  Pr.PriorityName,
  Pr.PriorityColor,
  C.CommentText
FROM Defects D
JOIN Projects P ON D.ProjectID = P.ProjectID
JOIN Employees PM ON P.ProjectID = (SELECT ProjectID FROM Employees WHERE PositionID = (SELECT PositionID FROM Positions WHERE PositionName = 'Project Manager') AND EmployeeID = PM.EmployeeID)
JOIN Employees DE ON D.DiscoveredBy = DE.EmployeeID
LEFT JOIN DefectStatusHistory DSH ON D.DefectID = DSH.DefectID
LEFT JOIN Statuses S ON DSH.StatusID = S.StatusID
LEFT JOIN Priorities Pr ON D.PriorityID = Pr.PriorityID
LEFT JOIN Comments C ON D.DefectID = C.DefectID;

-- 19. Выбрать количество дефектов, зафиксированных за текущий месяц клиентами 
-- по двум проектам (конкретные названия подставьте сами).
SELECT COUNT(*)
FROM Defects
WHERE EXTRACT(MONTH FROM DateDiscovered) = EXTRACT(MONTH FROM CURRENT_DATE)
AND EXTRACT(YEAR FROM DateDiscovered) = EXTRACT(YEAR FROM CURRENT_DATE)
AND DiscoveredBy IN (SELECT EmployeeID FROM Employees WHERE PositionID = (SELECT PositionID FROM Positions WHERE PositionName = 'Client'))
AND ProjectID IN (SELECT ProjectID FROM Projects WHERE ProjectName IN ('Project Alpha', 'Project Beta')); -- Замените названия проектов

-- 20. Выбрать название проекта и количество исправленных дефектов по проекту.
SELECT 
  P.ProjectName, 
  COUNT(D.DefectID) AS FixedDefectCount
FROM Projects P
LEFT JOIN Defects D ON P.ProjectID = D.ProjectID AND D.IsFixed = TRUE
GROUP BY P.ProjectName;

-- 21. Выбрать фамилию, имя, отчество клиента и количество дефектов, 
-- им зафиксированных по проекту N (конкретные названия подставьте сами).
SELECT 
  E.LastName, 
  E.FirstName, 
  E.MiddleName, 
  COUNT(D.DefectID) AS DefectsFound
FROM Employees E
LEFT JOIN Defects D ON E.EmployeeID = D.DiscoveredBy AND D.ProjectID = 1 -- Замените 1 на ID нужного проекта
WHERE E.PositionID = (SELECT PositionID FROM Positions WHERE PositionName = 'Client')
GROUP BY E.EmployeeID, E.LastName, E.FirstName, E.MiddleName;

-- 22. Выбрать фамилии, имена, отчества сотрудников, 
-- руководящих двумя-тремя проектами.
SELECT E.LastName, E.FirstName, E.MiddleName
FROM Employees E
JOIN Positions P ON E.PositionID = P.PositionID
WHERE P.PositionName = 'Project Manager'
GROUP BY E.EmployeeID, E.LastName, E.FirstName, E.MiddleName
HAVING COUNT(DISTINCT D.ProjectID) BETWEEN 2 AND 3;

-- 23. Выбрать id и название дефектов по проекту N, сменивших статус хотя бы дважды.
SELECT D.DefectID, D.DefectName
FROM Defects D
JOIN DefectStatusHistory DSH ON D.DefectID = DSH.DefectID
WHERE D.ProjectID = 1 -- Замените 1 на ID нужного проекта
GROUP BY D.DefectID, D.DefectName
HAVING COUNT(DSH.HistoryID) >= 2;

-- 24. Выбрать фамилии, имена, отчества клиентов, зафиксировавших три и более 
-- дефекта хотя бы по одному из проектов. Результат отсортировать по id_клиента.
SELECT E.LastName, E.FirstName, E.MiddleName
FROM Employees E
JOIN Defects D ON E.EmployeeID = D.DiscoveredBy
WHERE E.PositionID = (SELECT PositionID FROM Positions WHERE PositionName = 'Client')
GROUP BY E.EmployeeID, E.LastName, E.FirstName, E.MiddleName
HAVING COUNT(D.DefectID) >= 3
ORDER BY E.EmployeeID;

-- 25. Для каждого дефекта вывести названия всех статусов.
SELECT 
  D.DefectName,
  S.StatusName
FROM Defects D
CROSS JOIN Statuses S;

-- 26. Выбрать название проекта, id и названия всех дефектов и, 
-- если дефект исправлен, то фактическую дату исправления дефекта.
SELECT 
  P.ProjectName,
  D.DefectID,
  D.DefectName,
  CASE WHEN D.IsFixed THEN D.ActualFixTime ELSE NULL END AS ActualFixTime
FROM Projects P
JOIN Defects D ON P.ProjectID = D.ProjectID;

-- 27. Для каждого дефекта вывести названия всех статусов и, 
-- если дефект был в этом статусе, то дату изменения статуса.
SELECT 
  D.DefectName,
  S.StatusName,
  DSH.DateChanged AS StatusChangeDate
FROM Defects D
CROSS JOIN Statuses S
LEFT JOIN DefectStatusHistory DSH ON D.DefectID = DSH.DefectID AND S.StatusID = DSH.StatusID;


-- 28. Выбрать название проекта, фамилию, имя, отчество руководителя проекта и, 
-- если по проекту были неисправленные дефекты, то количество дефектов.
SELECT 
    p.ProjectName,
    pm.LastName,
    pm.FirstName,
    pm.MiddleName,
    COUNT(d.DefectID) AS UnresolvedDefects
FROM 
    Projects p
LEFT JOIN 
    (
        SELECT 
            ep.ProjectID,
            e.LastName,
            e.FirstName,
            e.MiddleName
        FROM 
            EmployeeProjects ep
        JOIN 
            Employees e ON e.EmployeeID = ep.EmployeeID
        JOIN 
            Positions pos ON pos.PositionID = e.PositionID
        WHERE 
            pos.PositionName = 'Project Manager'
    ) pm ON p.ProjectID = pm.ProjectID
LEFT JOIN 
    Defects d ON d.ProjectID = p.ProjectID AND d.IsFixed = false
GROUP BY 
    p.ProjectName, pm.LastName, pm.FirstName, pm.MiddleName;

-- 29. Выбрать количество исправленных дефектов по годам поквартально. 
-- В результирующей таблице должно быть пять столбцов: 
-- год, I квартал, II квартал, III квартал, IV квартал.
SELECT 
  EXTRACT(YEAR FROM ActualFixTime) AS FixYear,
  SUM(CASE WHEN EXTRACT(QUARTER FROM ActualFixTime) = 1 THEN 1 ELSE 0 END) AS Q1,
  SUM(CASE WHEN EXTRACT(QUARTER FROM ActualFixTime) = 2 THEN 1 ELSE 0 END) AS Q2,
  SUM(CASE WHEN EXTRACT(QUARTER FROM ActualFixTime) = 3 THEN 1 ELSE 0 END) AS Q3,
  SUM(CASE WHEN EXTRACT(QUARTER FROM ActualFixTime) = 4 THEN 1 ELSE 0 END) AS Q4
FROM Defects
WHERE IsFixed = TRUE
GROUP BY FixYear
ORDER BY FixYear;

-- 30. Выбрать все данные по неисправленным дефектам. 
-- Результат отсортировать по дате обнаружения.
SELECT *
FROM Defects
WHERE IsFixed = FALSE
ORDER BY DateDiscovered;

-- 31. Выбрать названия проектов, для которых не назначен руководитель.
LEFT JOIN 
    (
        SELECT 
            ep.ProjectID
        FROM 
            EmployeeProjects ep
        JOIN 
            Employees e ON e.EmployeeID = ep.EmployeeID
        JOIN 
            Positions pos ON pos.PositionID = e.PositionID
        WHERE 
            pos.PositionName = 'Project Manager'
    ) pm ON p.ProjectID = pm.ProjectID
WHERE 
    pm.ProjectID IS NULL;

-- 32. Вывести сообщение «Решение проблем затягивается», 
-- если есть нерешенные проблемы с прошедшей запланированной датой решения.
SELECT 
  CASE 
    WHEN EXISTS (SELECT 1 FROM Defects WHERE IsFixed = FALSE AND PlannedFixTime < CURRENT_DATE) 
    THEN 'Решение проблем затягивается' 
    ELSE 'Все в порядке' 
  END AS Message;

-- 33. Выбрать названия статусов, совпадающие с названием результата.
-- (Blocked, Closed = true; Open, In progress, Pending = false)
SELECT 
    s.StatusName
FROM 
    Statuses s
JOIN 
    (
        SELECT DISTINCT
            CASE
                WHEN d.IsFixed = false THEN 'Open'
                WHEN d.IsFixed = false THEN 'In progress'
                WHEN d.IsFixed = false THEN 'Pending'
                WHEN d.IsFixed = true THEN 'Closed'
                WHEN d.IsFixed = true THEN 'Blocked'
            END AS ResultStatus
        FROM 
            Defects d
    ) rs ON s.StatusName = rs.ResultStatus;


-- 34. Выбрать все данные по последнему зафиксированному дефекту.
SELECT *
FROM Defects
ORDER BY DateDiscovered DESC
LIMIT 1;

-- 35. Выбрать id дефекта, название, краткое и подробное описание, 
-- дату обнаружения, статус дефекта на сегодняшний день.
SELECT 
  D.DefectID,
  D.DefectName,
  D.ShortDescription,
  D.DetailedDescription,
  D.DateDiscovered,
  (SELECT S.StatusName FROM Statuses S JOIN DefectStatusHistory DSH ON S.StatusID = DSH.StatusID WHERE DSH.DefectID = D.DefectID ORDER BY DSH.DateChanged DESC LIMIT 1) AS CurrentStatus
FROM Defects D;

-- 36. Выбрать фамилию, имя, отчество сотрудника, зафиксировавшего наибольшее 
-- количество дефектов по какому-либо проекту в текущем месяце.
SELECT 
  E.LastName, 
  E.FirstName, 
  E.MiddleName
FROM Employees E
JOIN Defects D ON E.EmployeeID = D.DiscoveredBy
WHERE EXTRACT(MONTH FROM D.DateDiscovered) = EXTRACT(MONTH FROM CURRENT_DATE)
AND EXTRACT(YEAR FROM D.DateDiscovered) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY E.EmployeeID, E.LastName, E.FirstName, E.MiddleName
ORDER BY COUNT(D.DefectID) DESC
LIMIT 1;

-- 37. Выбрать для каждого проекта количество успешно исправленных и количество неисправленных дефектов.
SELECT 
  P.ProjectName,
  SUM(CASE WHEN D.IsFixed = TRUE THEN 1 ELSE 0 END) AS FixedDefects,
  SUM(CASE WHEN D.IsFixed = FALSE THEN 1 ELSE 0 END) AS UnfixedDefects
FROM Projects P
LEFT JOIN Defects D ON P.ProjectID = D.ProjectID
GROUP BY P.ProjectName;

-- 38. Выбрать всех участников проектов, в которых менее трех человек.
SELECT p.ProjectName, e.FirstName, e.LastName, e.MiddleName
FROM Projects p
JOIN (
    SELECT ProjectID, COUNT(EmployeeID) AS EmployeeCount
    FROM EmployeeProjects
    GROUP BY ProjectID
    HAVING COUNT(EmployeeID) < 3
) AS proj_counts ON p.ProjectID = proj_counts.ProjectID
JOIN EmployeeProjects ep ON p.ProjectID = ep.ProjectID
JOIN Employees e ON ep.EmployeeID = e.EmployeeID;


-- 39. Выбрать названия всех проектов, если у проекта есть руководитель, 
-- то фамилию и инициалы руководителя, если по проекту есть проблемы, 
-- то количество исправленных и количество неисправленных дефектов.
SELECT 
    p.ProjectName,
    CONCAT(e.LastName, ' ', LEFT(e.FirstName, 1), '.', LEFT(e.MiddleName, 1), '.') AS ProjectManager,
    COALESCE(SUM(CASE WHEN d.IsFixed = TRUE THEN 1 ELSE 0 END), 0) AS FixedDefectsCount,
    COALESCE(SUM(CASE WHEN d.IsFixed = FALSE THEN 1 ELSE 0 END), 0) AS UnfixedDefectsCount
FROM 
    Projects p
LEFT JOIN 
    (SELECT 
         e.EmployeeID,
         e.LastName,
         e.FirstName,
         e.MiddleName,
         e.PositionID,
         ep.ProjectID
     FROM 
         Employees e
     INNER JOIN
         Positions pos ON e.PositionID = pos.PositionID
     INNER JOIN
         EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
     WHERE 
         pos.PositionName = 'Project Manager') e ON p.ProjectID = e.ProjectID
LEFT JOIN 
    Defects d ON p.ProjectID = d.ProjectID
GROUP BY 
    p.ProjectID, p.ProjectName, e.LastName, e.FirstName, e.MiddleName
ORDER BY 
    p.ProjectName;


-- 40. Выбрать названия проектов, в которых количество разработчиков 
-- превышает среднее количество разработчиков по проектам.
WITH DeveloperCounts AS (
    SELECT 
        p.ProjectID,
        p.ProjectName,
        COUNT(e.EmployeeID) AS DeveloperCount
    FROM 
        Projects p
    LEFT JOIN 
        EmployeeProjects ep ON p.ProjectID = ep.ProjectID
    LEFT JOIN 
        Employees e ON ep.EmployeeID = e.EmployeeID
    INNER JOIN
        Positions pos ON e.PositionID = pos.PositionID
    WHERE 
        pos.PositionName = 'Developer'
    GROUP BY 
        p.ProjectID, p.ProjectName
),
AverageDeveloperCount AS (
    SELECT 
        AVG(DeveloperCount) AS AvgDeveloperCount
    FROM 
        DeveloperCounts
)
SELECT 
    dc.ProjectName,
    dc.DeveloperCount,
    adc.AvgDeveloperCount
FROM 
    DeveloperCounts dc,
    AverageDeveloperCount adc
WHERE 
    dc.DeveloperCount > adc.AvgDeveloperCount
ORDER BY 
    dc.ProjectName;


-- 41. Выбрать дефекты, которые заблокированы другими дефектами.
SELECT D1.*
FROM Defects D1
JOIN DefectDependencies DD ON D1.DefectID = DD.DefectID;

-- 42. Выбрать дефекты, которые заблокировали группу других дефектов.
SELECT D1.*
FROM Defects D1
JOIN DefectDependencies DD ON D1.DefectID = DD.DependsOnDefectID
GROUP BY D1.DefectID
HAVING COUNT(*) > 1;

-- 43. В одном столбце вывести фамилию, имя, отчество всех, кто связан с проектом Х. 
-- Результат отсортировать по фамилии и имени в лексикографическом порядке.
SELECT 
    e.LastName || ' ' || e.FirstName || ' ' || COALESCE(e.MiddleName, '') AS FullName
FROM 
    Employees e
INNER JOIN 
    EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
INNER JOIN 
    Projects p ON ep.ProjectID = p.ProjectID
WHERE 
    p.ProjectName = 'ProjectName'
ORDER BY 
    e.LastName, e.FirstName;


-- 44. Выбрать общее количество однофамильцев-тезок в БД.
SELECT 
    (SELECT COUNT(*)
     FROM (
         SELECT FirstName
         FROM Employees
         GROUP BY FirstName
         HAVING COUNT(*) > 1
     ) AS NameDuplicates) +
    (SELECT COUNT(*)
     FROM (
         SELECT LastName
         FROM Employees
         GROUP BY LastName
         HAVING COUNT(*) > 1
     ) AS LastNameDuplicates) AS TotalDuplicates;

-- 45. Выбрать месяцы текущего и прошлого годов, в которых закрыто наибольшее количество дефектов.
SELECT 
  EXTRACT(MONTH FROM D.ActualFixTime) AS MonthFixed,
  COUNT(*) AS DefectsFixed
FROM Defects D
WHERE EXTRACT(YEAR FROM D.ActualFixTime) IN (EXTRACT(YEAR FROM CURRENT_DATE), EXTRACT(YEAR FROM CURRENT_DATE) - 1)
AND D.IsFixed = TRUE
GROUP BY MonthFixed
ORDER BY DefectsFixed DESC;

-- 46. Выбрать тройку последних дефектов по проекту N.
SELECT *
FROM Defects
WHERE ProjectID = 1 -- Замените 1 на ID нужного проекта
ORDER BY DateDiscovered DESC
LIMIT 3;

-- 47. Выбрать дефекты с ошибками перехода статуса.
-- (Необходимо уточнить условия, при которых переход статуса считается ошибочным)

-- 48. Выбрать для каждой даты текущего месяца количество зафиксированных дефектов. 
-- Учесть, что могут быть дни, в которые не обнаруживались дефекты. 
-- Для таких дат вывести 0.
WITH DateSeries AS (
  SELECT generate_series(date_trunc('month', CURRENT_DATE), date_trunc('month', CURRENT_DATE) + interval '1 month' - interval '1 day', interval '1 day') AS dt
)
SELECT 
  DS.dt, 
  COALESCE(COUNT(D.DefectID), 0) AS DefectCount
FROM DateSeries DS
LEFT JOIN Defects D ON DS.dt = D.DateDiscovered::date
GROUP BY DS.dt
ORDER BY DS.dt;

-- 49. Выбрать все цепочки связи дефектов.
-- (Рекурсивный запрос для построения цепочек связей)
WITH RECURSIVE DefectHierarchy AS (
  SELECT 
    DefectID AS RootDefectID, 
    DefectID, 
    DependsOnDefectID, 
    1 AS Level,
    CAST(DefectID AS TEXT) AS Path
  FROM DefectDependencies
  UNION ALL
  SELECT 
    dh.RootDefectID, 
    dd.DefectID, 
    dd.DependsOnDefectID, 
    dh.Level + 1,
    dh.Path || '->' || CAST(dd.DefectID AS TEXT) 
  FROM DefectDependencies dd
  JOIN DefectHierarchy dh ON dd.DependsOnDefectID = dh.DefectID 
)
SELECT * FROM DefectHierarchy ORDER BY RootDefectID, Level, Path;

-- 50. Выбрать самую длинную цепочку связи дефектов.
WITH RECURSIVE DefectHierarchy AS (
  SELECT 
    DefectID AS RootDefectID, 
    DefectID, 
    DependsOnDefectID, 
    1 AS Level,
    CAST(DefectID AS TEXT) AS Path
  FROM DefectDependencies
  UNION ALL
  SELECT 
    dh.RootDefectID, 
    dd.DefectID, 
    dd.DependsOnDefectID, 
    dh.Level + 1,
    dh.Path || '->' || CAST(dd.DefectID AS TEXT) 
  FROM DefectDependencies dd
  JOIN DefectHierarchy dh ON dd.DependsOnDefectID = dh.DefectID 
)
SELECT Path, Level
FROM DefectHierarchy 
ORDER BY Level DESC
LIMIT 1;
