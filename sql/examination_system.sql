/*
Navicat MySQL Data Transfer

Source Server         : MySQL
Source Server Version : 50716
Source Host           : localhost:3306
Source Database       : examination_system

Target Server Type    : MYSQL
Target Server Version : 50716
File Encoding         : 65001

Date: 2017-07-08 00:03:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for college
-- ----------------------------
DROP TABLE IF EXISTS `college`;
CREATE TABLE `college` (
  `collegeID` int(11) NOT NULL,
  `collegeName` varchar(200) NOT NULL COMMENT '课程名',
  PRIMARY KEY (`collegeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of college
-- ----------------------------
INSERT INTO `college` VALUES ('1', '初级班');
INSERT INTO `college` VALUES ('2', '中级班');
INSERT INTO `college` VALUES ('3', '高级班');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `courseID` int(11) NOT NULL,
  `courseName` varchar(200) NOT NULL COMMENT '课程名称',
  `teacherID` int(11) NOT NULL,
  `courseTime` varchar(200) DEFAULT NULL COMMENT '开课时间',
  `classRoom` varchar(200) DEFAULT NULL COMMENT '开课地点',
  `courseWeek` int(200) DEFAULT NULL COMMENT '学时',
  `courseType` varchar(20) DEFAULT NULL COMMENT '课程类型',
  `collegeID` int(11) NOT NULL COMMENT '所属班级',
  `score` int(11) NOT NULL COMMENT '节数',
  PRIMARY KEY (`courseID`),
  KEY `collegeID` (`collegeID`),
  KEY `teacherID` (`teacherID`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`collegeID`) REFERENCES `college` (`collegeID`),
  CONSTRAINT `course_ibfk_2` FOREIGN KEY (`teacherID`) REFERENCES `teacher` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('1', '指法', '1001', '周二', '琴房401', '18', '必修课', '1', '3');
INSERT INTO `course` VALUES ('2', '琴法', '1002', '周四', '琴房402', '18', '必修课', '1', '3');


-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `roleID` int(11) NOT NULL,
  `roleName` varchar(20) NOT NULL,
  `permissions` varchar(255) DEFAULT NULL COMMENT '权限',
  PRIMARY KEY (`roleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('0', 'admin', null);
INSERT INTO `role` VALUES ('1', 'teacher', null);
INSERT INTO `role` VALUES ('2', 'student', null);

-- ----------------------------
-- Table structure for selectedcourse
-- ----------------------------
DROP TABLE IF EXISTS `selectedcourse`;
CREATE TABLE `selectedcourse` (
  `courseID` int(11) NOT NULL,
  `studentID` varchar(11) NOT NULL,
  `mark` int(11) DEFAULT NULL COMMENT '成绩',
  KEY `courseID` (`courseID`),
  KEY `studentID` (`studentID`),
  CONSTRAINT `selectedcourse_ibfk_1` FOREIGN KEY (`courseID`) REFERENCES `course` (`courseID`),
  CONSTRAINT `selectedcourse_ibfk_2` FOREIGN KEY (`studentID`) REFERENCES `student` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of selectedcourse
-- ----------------------------
INSERT INTO `selectedcourse` VALUES ('2', '12344556', '12');
INSERT INTO `selectedcourse` VALUES ('1', '10002', '66');
INSERT INTO `selectedcourse` VALUES ('1', '10003', null);
INSERT INTO `selectedcourse` VALUES ('2', '10003', '99');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `userID` varchar(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(200) NOT NULL,
  `sex` varchar(20) DEFAULT NULL,
  `birthYear` date DEFAULT NULL COMMENT '出生日期',
  `grade` date DEFAULT NULL COMMENT '入学时间',
  `collegeID` int(11) NOT NULL COMMENT '院系id',
  PRIMARY KEY (`userID`),
  KEY `collegeID` (`collegeID`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`collegeID`) REFERENCES `college` (`collegeID`)
) ENGINE=InnoDB AUTO_INCREMENT=10007 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('10001', '小黄', '男', '1996-09-02', '2015-09-02', '1');
INSERT INTO `student` VALUES ('10002', '小米', '女', '1995-09-14', '2015-09-02', '3');
INSERT INTO `student` VALUES ('10003', '小陈', '女', '1996-09-02', '2015-09-02', '2');
INSERT INTO `student` VALUES ('10004', '小华', '男', '1996-09-02', '2015-09-02', '2');
INSERT INTO `student` VALUES ('10005', '小左', '女', '1996-09-02', '2015-09-02', '2');
INSERT INTO `student` VALUES ('10006', '小拉', '女', '1996-09-02', '2015-09-02', '1');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(200) NOT NULL,
  `sex` varchar(20) DEFAULT NULL,
  `birthYear` date NOT NULL,
  `degree` varchar(20) DEFAULT NULL COMMENT '学历',
  `title` varchar(255) DEFAULT NULL COMMENT '职称',
  `grade` date DEFAULT NULL COMMENT '入职时间',
  `collegeID` int(11) NOT NULL COMMENT '院系',
  PRIMARY KEY (`userID`),
  KEY `collegeID` (`collegeID`),
  CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`collegeID`) REFERENCES `college` (`collegeID`)
) ENGINE=InnoDB AUTO_INCREMENT=1004 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('1001', '刘老师', '女', '1990-03-08', '硕士', '副教授', '2015-09-02', '2');
INSERT INTO `teacher` VALUES ('1002', '张老师', '男', '1996-09-02', '本科', '普通教师', '2015-09-02', '1');
INSERT INTO `teacher` VALUES ('1003', '软老师', '男', '1996-09-02', '硕士', '助教', '2017-07-07', '1');

-- ----------------------------
-- Table structure for userlogin
-- ----------------------------
DROP TABLE IF EXISTS `userlogin`;
CREATE TABLE `userlogin` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `role` int(11) NOT NULL DEFAULT '2' COMMENT '角色权限',
  PRIMARY KEY (`userID`),
  KEY `role` (`role`),
  CONSTRAINT `userlogin_ibfk_1` FOREIGN KEY (`role`) REFERENCES `role` (`roleID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userlogin
-- ----------------------------
INSERT INTO `userlogin` VALUES ('1', 'admin', '123', '0');
INSERT INTO `userlogin` VALUES ('8', '10001', '123', '2');
INSERT INTO `userlogin` VALUES ('9', '10002', '123', '2');
INSERT INTO `userlogin` VALUES ('10', '10003', '123', '2');
INSERT INTO `userlogin` VALUES ('11', '10005', '123', '2');
INSERT INTO `userlogin` VALUES ('12', '10004', '123', '2');
INSERT INTO `userlogin` VALUES ('13', '10006', '123', '2');
INSERT INTO `userlogin` VALUES ('14', '1001', '123', '1');
INSERT INTO `userlogin` VALUES ('15', '1002', '123', '1');
INSERT INTO `userlogin` VALUES ('16', '1003', '123', '1');
SET FOREIGN_KEY_CHECKS=1;


DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `productId` int(11) NOT NULL AUTO_INCREMENT,
  `imgurl` varchar(200) NOT NULL,
  `intro` varchar(200) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`productId`)
) ENGINE=InnoDB AUTO_INCREMENT=1004 DEFAULT CHARSET=utf8;

INSERT INTO `product` VALUES ('1', 'qin1.jpg','润扬民乐 黑檀素面专业演奏古筝 可选便携式小古筝 黑檀琴码', '1999');
INSERT INTO `product` VALUES ('2', 'qin2.jpg', '收藏级非洲黑檀深雕九龙古筝 有收藏证书 大师监制', '2000');



DROP TABLE IF EXISTS `od`;
CREATE TABLE `od` (
  `oId` int(11) NOT NULL,
  `orderId` varchar(12) NOT NULL,
  `productId` int(11) NOT NULL,
  `productNum` int(11) NOT NULL,
  `productIntro` varchar(200) NOT NULL,
  `create_time`  datetime DEFAULT CURRENT_TIMESTAMP,
  `openId` varchar(100) NOT NULL,
  PRIMARY KEY (`oId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `od` VALUES ('1', '5656757','1','2','润扬民乐 黑檀素面专业演奏古筝 可选便携式小古筝 黑檀琴码', now(),'oYcIXwVLgOdcWwdCk9EL8R02Ipa0');


DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `messageId` int(11) NOT NULL,
  `content` varchar(200) NOT NULL,
  PRIMARY KEY (`messageId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `workspace`;
CREATE TABLE `workspace` (
  `wId` int(11) NOT NULL,
  `wIntro` varchar(255) NOT NULL,
  `wObject` varchar(255) NOT NULL,
  `wSchema` varchar(255) NOT NULL,
  `wRemind` varchar(255) NOT NULL,
  `wAddress` varchar(255) NOT NULL,
  `wPhone` varchar(255) NOT NULL,
  `gContent` varchar(255) NOT NULL,
  `gTime` varchar(255) NOT NULL,
  `gAddress` varchar(255) NOT NULL,
  `gRemind` varchar(255) NOT NULL,
  PRIMARY KEY (`wId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `workspace` VALUES ('1', 
' 中筝琴行是一家从事以古筝培训的专业机构本，琴行环境优美，拥有郑州较好的古筝教学师资团队，教学成果显著。师生时常参加全国，省，市各级比赛，硕果累累。学生连年过级率高，并有数名学员获得“优”，“良”的等级！深得家长及学员的一致好评！',
'少儿和成人（5岁以上均可）',
'一对一    一对二   小组课',
'本中心常年招生，教学模式先进，时段灵活。',
'郑州市人民公园东门北100米',
'13778012983（张老师）',
'为了提高大家的专业素养，增加学员之间的交流，本琴行特意举行小型音乐见面会，欢迎广大学员报名参加!报名请联系张老师（13778012983）。',
'2020年5月2日 19点',
'中筝琴行一楼大厅',
'需自己准备好参加音乐会的曲子'
);



INSERT INTO `teacher` VALUES ('1001', '张明', '女', '1990-03-08', '硕士', '副教授', '2015-09-02', '2','毕业于中央音乐学院，主修古筝，毕业后一直从事古筝教学，具有丰富的教学经验
能够根据学生的性格特点和心理特征因材施教，培育过的许多学生都以优异的成绩通过的
试。','teacher1.jpg');  
INSERT INTO `teacher` VALUES ('1002', '王强', '男', '1990-03-08', '硕士', '副教授', '2013-09-02', '2','毕业于上海音乐学院，主修古筝，工作经验长达十年，教学经验丰富，有耐心，收到家长的好评，培训的学生在全国明日之星比赛的总决赛中获得儿童组金奖','teacher2.jpg');
INSERT INTO `teacher` VALUES ('1003', '李霞', '女', '1990-03-08', '硕士', '副教授', '2013-09-02', '2','毕业于郑州大学音乐学院，主修古筝，毕业后一直从事古筝教学，具有丰富的教学经验
能够根据学生的性格特点和心理特征因材施教，培育过的许多学生都以优异的成绩通过的
试。','teacher3.jpg');  
INSERT INTO `teacher` VALUES ('1004', '赵慧', '女', '1990-03-08', '硕士', '副教授', '2013-09-02', '2','毕业于沈阳音乐学院，主修古筝，工作认真负责，培育过的许多学生都以优异的成绩通过的,在古筝艺术周的初赛中以优异的成绩进入复赛，本人也被评为优秀指导老师','teacher4.jpg');  
毕业于郑州大学音乐学院，主修古筝,2019年被中国管弦协会评为优秀考级指导老师，教学理念较为先进





 