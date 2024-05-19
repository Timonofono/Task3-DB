--Создание таблицы автобусных остановок
CREATE TABLE BusStop
(
 id INT NOT NULL PRIMARY KEY,
 name NVARCHAR(50) NOT NULL
) AS NODE;

--Добавление в таблицу BusStop нескольких остановок
INSERT INTO BusStop (id, name)
VALUES (1, N'Нарочанская'),
       (2, N'Университет физкультуры'),
	   (3, N'Комсомольское озеро'),
	   (4, N'Замчище'),
	   (5, N'Ленина');

--Содержимое таблицы BusStop
SELECT * FROM BusStop

--Создание таблицы станций метро
CREATE TABLE MetroStation
(
 id INT NOT NULL PRIMARY KEY,
 name NVARCHAR(30) NOT NULL,
 line NVARCHAR(30) NOT NULL
) AS NODE;

--Добавление в таблицу MetroStation нескольких станций
INSERT INTO MetroStation (id, name, line)
VALUES (110, N'Малі́наўка', N'Маскоўская'),
       (111, N'Пятро́ўшчына', N'Маскоўская'),
	   (115, N'Пло́шча Ле́ніна', N'Маскоўская'),
	   (116, N'Кастры́чніцкая', N'Маскоўская'),
	   (118, N'Пло́шча Яку́ба Ко́ласа', N'Маскоўская'),
	   (119, N'Акадэ́мія наву́к', N'Маскоўская'),
	   (122, N'Усхо́д', N'Маскоўская');

--Содержимое таблицы MetroStation
SELECT * FROM MetroStation

--Создание таблицы Достопримечательностей
CREATE TABLE Landmark
(
 id INT NOT NULL PRIMARY KEY,
 name NVARCHAR(50),
 type NVARCHAR(30)
) AS NODE;

--Добавление в таблицу BusStop нескольких остановок
INSERT INTO Landmark (id, name, type)
VALUES (1, N'Музей ВОВ', N'Музей'),
	   (2, N'Национальная библиотека', N'Библиотека'),
	   (3, N'Статуя Якуба Коласа', N'Статуя'),
	   (4, N'Национальная академия наук', N'Здание'),
	   (5, N'Красный костёл', N'Костёл'),
	   (6, N'Статуя Ленина', N'Статця'),
	   (7, N'Театр Янки Купалы', N'Театр'),
	   (8, N'Собор сошествия Св. Духа', N'Церковь');

--Содержимое таблицы MetroStation
SELECT * FROM Landmark

--Создание таблицы рёбер BusRoute
CREATE TABLE BusRoute AS EDGE;

--Просмотр столбцов в таблице BusRoute
SELECT * FROM BusRoute

--Добавление данных в таблицу BusRoute
INSERT INTO BusRoute ($from_id, $to_id)
VALUES ((SELECT $node_id FROM BusStop Where id = 1), (SELECT $node_id FROM BusStop WHERE id = 2)),
	   ((SELECT $node_id FROM BusStop Where id = 2), (SELECT $node_id FROM BusStop WHERE id = 3)),
	   ((SELECT $node_id FROM BusStop Where id = 3), (SELECT $node_id FROM BusStop WHERE id = 4)),
	   ((SELECT $node_id FROM BusStop Where id = 4), (SELECT $node_id FROM BusStop WHERE id = 5))

--Просмотр данных в таблице BusRoute
SELECT * FROM BusRoute

--Создаём ещё 4 таблицы рёбер
CREATE TABLE MetroLine AS EDGE; -- Линия метро
CREATE TABLE WalkingPath AS EDGE; -- Пеший маршрут
CREATE TABLE LandmarkOnMetroStation AS EDGE; -- Достопримечательность на станции метро
CREATE TABLE LandmarkOnBusStation AS EDGE; -- Достопримечательность на остановке автобуса


--Заполнение таблицы рёбер MetroLine
INSERT INTO MetroLine ($from_id, $to_id)
VALUES ((SELECT $node_id FROM MetroStation Where id = 110), (SELECT $node_id FROM MetroStation WHERE id = 111)),
	   ((SELECT $node_id FROM MetroStation Where id = 111), (SELECT $node_id FROM MetroStation WHERE id = 115)),
	   ((SELECT $node_id FROM MetroStation Where id = 115), (SELECT $node_id FROM MetroStation WHERE id = 116)),
	   ((SELECT $node_id FROM MetroStation Where id = 116), (SELECT $node_id FROM MetroStation WHERE id = 118)),
	   ((SELECT $node_id FROM MetroStation Where id = 118), (SELECT $node_id FROM MetroStation WHERE id = 119)),
	   ((SELECT $node_id FROM MetroStation Where id = 119), (SELECT $node_id FROM MetroStation WHERE id = 122));

--Заполнение таблицы рёбер WalkingPath
INSERT INTO WalkingPath ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Landmark Where id = 2), (SELECT $node_id FROM Landmark WHERE id = 4)),
	   ((SELECT $node_id FROM Landmark Where id = 4), (SELECT $node_id FROM Landmark WHERE id = 3)),
	   ((SELECT $node_id FROM Landmark Where id = 3), (SELECT $node_id FROM Landmark WHERE id = 7)),
	   ((SELECT $node_id FROM Landmark Where id = 7), (SELECT $node_id FROM Landmark WHERE id = 5)),
	   ((SELECT $node_id FROM Landmark Where id = 5), (SELECT $node_id FROM Landmark WHERE id = 6)),
	   ((SELECT $node_id FROM Landmark Where id = 6), (SELECT $node_id FROM Landmark WHERE id = 8)),
	   ((SELECT $node_id FROM Landmark Where id = 8), (SELECT $node_id FROM Landmark WHERE id = 1));

--Заполнение таблицы рёбер LandmarkOnMetroStation
INSERT INTO LandmarkOnMetroStation ($from_id, $to_id)
VALUES ((SELECT $node_id FROM MetroStation Where id = 122), (SELECT $node_id FROM Landmark WHERE id = 2)),
	   ((SELECT $node_id FROM MetroStation Where id = 119), (SELECT $node_id FROM Landmark WHERE id = 4)),
	   ((SELECT $node_id FROM MetroStation Where id = 118), (SELECT $node_id FROM Landmark WHERE id = 3)),
	   ((SELECT $node_id FROM MetroStation Where id = 116), (SELECT $node_id FROM Landmark WHERE id = 7)),
	   ((SELECT $node_id FROM MetroStation Where id = 115), (SELECT $node_id FROM Landmark WHERE id = 5)),
	   ((SELECT $node_id FROM MetroStation Where id = 115), (SELECT $node_id FROM Landmark WHERE id = 6));

--Заполнение таблицы рёбер LandmarkOnBusStation
INSERT INTO LandmarkOnBusStation ($from_id, $to_id)
VALUES ((SELECT $node_id FROM BusStop Where id = 3), (SELECT $node_id FROM Landmark WHERE id = 1)),
	   ((SELECT $node_id FROM BusStop Where id = 4), (SELECT $node_id FROM Landmark WHERE id = 8)),
	   ((SELECT $node_id FROM BusStop Where id = 5), (SELECT $node_id FROM Landmark WHERE id = 5)),
	   ((SELECT $node_id FROM BusStop Where id = 5), (SELECT $node_id FROM Landmark WHERE id = 6));


--Добавление ограничений
ALTER TABLE BusRoute ADD CONSTRAINT EC_BusRoute CONNECTION (BusStop TO BusStop);
ALTER TABLE MetroLine ADD CONSTRAINT EC_MetroLine CONNECTION (MetroStation TO MetroStation);
ALTER TABLE WalkingPath ADD CONSTRAINT EC_WalkingPath CONNECTION (Landmark TO Landmark);

--Запросы с MATCH
SELECT DISTINCT b.name
FROM BusStop AS start, BusRoute, BusStop AS b
WHERE MATCH(start-(BusRoute)->b)
AND start.name = N'Нарочанская';

SELECT *
FROM MetroStation
WHERE line = N'Маскоўская';

SELECT l.name AS landmark_name, b.name AS bus_stop_name
FROM Landmark AS l, LandmarkOnBusStation, BusStop AS b
WHERE MATCH(b-(LandmarkOnBusStation)->l);

SELECT l.name AS landmark_name, m.name AS metro_station_name
FROM Landmark AS l, LandmarkOnMetroStation, MetroStation AS m
WHERE MATCH(m-(LandmarkOnMetroStation)->l);

SELECT l1.name AS landmark1, l2.name AS landmark2
FROM Landmark AS l1, WalkingPath, Landmark AS l2
WHERE MATCH(l1-(WalkingPath)->l2);


--Запросы с SHORTEST_PATH
SELECT start.name AS StartName,
       STRING_AGG(station_name, '->') WITHIN GROUP (GRAPH PATH) AS Route
FROM MetroStation AS start, MetroLine FOR PATH AS ml, MetroStation FOR PATH AS station
WHERE MATCH(SHORTEST_PATH(start(-(ml)->station)+))
AND start.name = N'Малі́наўка'
AND station.name = N'Усхо́д';

SELECT start.name AS StartName,
       STRING_AGG(stop_name, '->') WITHIN GROUP (GRAPH PATH) AS Route
FROM BusStop AS start, BusRoute FOR PATH AS br, BusStop FOR PATH AS stop
WHERE MATCH(SHORTEST_PATH(start(-(br)->stop)+))
AND start.name = N'Нарочанская'
AND stop.name = N'Ленина';


