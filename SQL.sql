SELECT column_name1,column_name2;		 # 从table中选取特定名称列


SELECT * FROM table_name;		     # 从table中选取所有列
SELECT column_name AS alias_name FROM table_name;  # 从table中选取所有列,并取别名

SELECT DISTINCT		# 与以上两行相比，返回值去掉了重复值


+----+--------------+---------------------------+-------+---------+
| id | name         | url                       | alexa | country |
+----+--------------+---------------------------+-------+---------+
| 1  | Google       | https://www.google.cm/    | 1     | USA     |
| 2  | 淘宝          | https://www.taobao.com/   | 13    | CN      |
| 3  | 菜鸟教程      | http://www.runoob.com/    | 4689  | CN      |
| 4  | 微博          | http://weibo.com/         | 20    | CN      |
| 5  | Facebook     | https://www.facebook.com/ | 3     | USA     |
+----+--------------+---------------------------+-------+---------+


SELECT column_name,column_name FROM table_name WHERE column_name operator value;   # WHERE 子句用于提取那些满足指定条件的记录


SELECT * FROM Websites WHERE country='CN' AND alexa > 50;		#从 "Websites" 表中选取国家为 "CN" 且alexa排名大于 "50" 的所有网站
SELECT * FROM Websites WHERE country='CN' OR alexa > 50;		#从 "Websites" 表中选取国家为 "CN" 或者alexa排名大于 "50" 的所有网站
# IN 操作符允许在 WHERE 子句中规定多个值。
SELECT * FROM Websites WHERE name IN ('Google','菜鸟教程');		#选取 name 为 "Google" 或 "菜鸟教程" 的所有网站
#BETWEEN 操作符用于选取介于两个值之间的数据范围内的值
#NOT BETWEEN 类似
SELECT * FROM Websites WHERE alexa BETWEEN 1 AND 20;            #选取 alexa 介于 1 和 20 之间的所有网站
SELECT * FROM Websites WHERE name NOT BETWEEN 'A' AND 'H';	    #选取 name 不在 'A' 和 'H' 之间字母开始的所有网站
SELECT * FROM access_log WHERE date BETWEEN '2016-05-10' AND '2016-05-14';  #选取 date 介于 '2016-05-10' 和 '2016-05-14' 之间的所有访问记录
# LIKE 操作符用于在 WHERE 子句中搜索列中的指定模式。
#通配符：%	替代 0 个或多个字符
         _	替代一个字符
SELECT * FROM Websites WHERE name LIKE 'G%';                   #选取name以字母 "G" 开始的所有客户
SELECT * FROM Websites WHERE name LIKE '%k';				   #选取name以字母 "k" 结尾的所有客户
SELECT * FROM Websites WHERE name LIKE '%oo%'; 				   #选取name包含"oo"的所有客户
SELECT * FROM Websites WHERE url LIKE '%oo%';				   #选取 url 包含"oo"的所有网站
SELECT * FROM Websites WHERE name LIKE '_oogle';               #选取name以一个任意字符开始，然后是 "oogle" 的所有客户
# 使用 NOT 关键字，可以选取不匹配模式的记录
SELECT * FROM Websites WHERE name NOT LIKE '%oo%';             #选取 name 不包含模式 "oo" 的所有客户


SELECT * FROM Websites ORDER BY alexa;		#从 "Websites" 表中选取所有网站，并按照 "alexa" 列升序排序
SELECT * FROM Websites ORDER BY alexa DESC; #从 "Websites" 表中选取所有网站，并按照 "alexa" 列降序排序


INSERT INTO Websites (name, url, country) VALUES ('stackoverflow', 'http://stackoverflow.com/', 'IND'); # 插入一个新行，但是只在 "name"、"url" 和 "country" 列插入数据（id 字段会自动更新）


UPDATE Websites SET alexa='5000', country='USA'  WHERE name='菜鸟教程';  #把 "菜鸟教程" 的 alexa 排名更新为 5000，country 改为 USA


DELETE FROM Websites WHERE name='Facebook' AND country='USA';  #从 "Websites" 表中删除网站名为 "Facebook" 且国家为 USA 的网站
DELETE * FROM table_name;   								   #删除所有数据


SELECT * FROM Websites LIMIT 2;		   #从 "Websites" 表中选取前两条记录（MySQL 支持 LIMIT 语句来选取指定的条数数据）
SELECT TOP 50 PERCENT * FROM Websites; #从 websites 表中选取前面百分之 50 的记录（ Microsoft SQL Server 数据库中可执行）


A inner join B 取交集。
A left join B 取 A 全部，B 没有对应的值为 null。
A right join B 取 B 全部 A 没有对应的值为 null。
A full outer join B 取并集，彼此没有对应的值为 null。
对应条件在 on 后面填写

UNION 操作符：合并两个或多个 SELECT 语句的结果（不重复），允许重复的值，使用 UNION ALL
（SELECT country FROM Websites）UNION ALL（SELECT country FROM apps）ORDER BY country; #"Websites" 和 "apps" 表中选取所有的country（也有重复的值）


SELECT INTO 语句从一个表复制数据，然后把数据插入到另一个新表中
SELECT * INTO newtable FROM table1;		#复制所有的列插入到新表中
SELECT * INTO WebsitesBackup2016 FROM Websites WHERE country='CN'  #只复制中国的网站插入到新表中
MySQL 数据库不支持 SELECT ... INTO 语句,故使用 CREATE TABLE newtable AS SELECT * FROM oldtable 以实现相同目的


INSERT INTO SELECT 语句从一个表复制数据，然后把数据插入到一个已存在的表中
INSERT INTO Websites (name, country) SELECT appname, country FROM apps;  #复制 "apps" 中的数据插入到 "Websites" 中


CREATE DATABASE my_db;   #创建一个名为 "my_db" 的数据库

CREATE TABLE 语句用于创建数据库中的表，表由行和列组成，每个表都必须有个表名：
CREATE TABLE table_name
(
column_name1 data_type(size),
column_name2 data_type(size),
column_name3 data_type(size),
);
'
column_name 参数规定表中列的名称。
data_type 参数规定列的数据类型（例如 varchar、integer、decimal、date 等等）。
size 参数规定表中列的最大长度。
'


SQL 约束(CONSTRAINTS):
用于规定表中的数据规则。
如果存在违反约束的数据行为，行为会被约束终止。
约束可以在创建表时规定（通过 CREATE TABLE 语句），或者在表创建之后规定（通过 ALTER TABLE 语句）。
CREATE TABLE table_name
(
column_name1 data_type(size) constraint_name,
column_name2 data_type(size) constraint_name,
column_name3 data_type(size) constraint_name,
....
);
 SQL 强制 "ID" 列、 "LastName" 列以及 "FirstName" 列不接受 NULL 值的实例：
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255) NOT NULL,
    Age int
);

在一个已创建的表的 "Age" 字段中添加 NOT NULL 约束：
ALTER TABLE Persons
MODIFY Age int NOT NULL;
在一个已创建的表的 "Age" 字段中删除 NOT NULL 约束：
ALTER TABLE Persons
MODIFY Age int NULL;

约束方式（constraint_name）：
NOT NULL - 指示某列不能存储 NULL 值。
UNIQUE - 保证某列的每行必须有唯一的值。
PRIMARY KEY - NOT NULL 和 UNIQUE 的结合。确保某列（或两个列多个列的结合）有唯一标识，有助于更容易更快速地找到表中的一个特定的记录。
FOREIGN KEY - 保证一个表中的数据匹配另一个表中的值的参照完整性。
CHECK - 保证列中的值符合指定的条件。
DEFAULT - 规定没有给列赋值时的默认值