/*
Source Server         : local
Source Server Version : 50709
Source Host           : localhost:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50709
File Encoding         : 65001

Date: 2016-11-28 10:17:23
*/
CREATE USER 'r00t'@'localhost' IDENTIFIED BY 'r00t';

GRANT GRANT OPTION ON *.* TO 'r00t'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER ON *.* TO 'r00t'@'localhost';


SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for rol
-- ----------------------------
DROP TABLE IF EXISTS `rol`;
CREATE TABLE `rol` (
  `id_rol` varchar(255) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rol
-- ----------------------------
INSERT INTO `rol` VALUES ('ADMINISTRADOR', 'administrador');
INSERT INTO `rol` VALUES ('USUARIO', 'usuario');

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `id_usuario` varchar(64) NOT NULL,
  `contrasenia` varchar(255) NOT NULL,
  `activo` char(2) NOT NULL DEFAULT 'SI',
  `logueado` char(2) NOT NULL DEFAULT 'NO',
  `ultimo_acceso` datetime DEFAULT NULL,
  `numero_intentos` int(11) NOT NULL DEFAULT '0',
  `bloqueado` char(2) NOT NULL DEFAULT 'NO',
  `fecha_bloqueo` datetime DEFAULT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usuario
-- ----------------------------
INSERT INTO `usuario` VALUES ('admin', '5f4dcc3b5aa765d61d8327deb882cf99', 'SI', 'NO', '2016-11-23 03:09:50', '0', 'NO', null);
INSERT INTO `usuario` VALUES ('usuario1', '5f4dcc3b5aa765d61d8327deb882cf99', 'SI', 'SI', '2016-08-10 00:30:05', '0', 'NO', null);
INSERT INTO `usuario` VALUES ('usuario2', '5f4dcc3b5aa765d61d8327deb882cf99', 'SI', 'SI', '2016-04-04 00:07:44', '0', 'NO', null);
INSERT INTO `usuario` VALUES ('usuario3', '5f4dcc3b5aa765d61d8327deb882cf99', 'SI', 'NO', null, '0', 'NO', null);

-- ----------------------------
-- Table structure for usuario_datos
-- ----------------------------
DROP TABLE IF EXISTS `usuario_datos`;
CREATE TABLE `usuario_datos` (
  `id_usuario` varchar(64) NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `apellido_paterno` varchar(120) NOT NULL,
  `apellido_materno` varchar(120) DEFAULT '',
  `sexo` varchar(10) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `usuario_datos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usuario_datos
-- ----------------------------

-- ----------------------------
-- Table structure for usuario_rol
-- ----------------------------
DROP TABLE IF EXISTS `usuario_rol`;
CREATE TABLE `usuario_rol` (
  `id_usuario_rol` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_usuario` varchar(64) NOT NULL,
  `id_rol` varchar(255) NOT NULL,
  PRIMARY KEY (`id_usuario_rol`),
  UNIQUE KEY `usuario_id_usuario_rol_r1` (`id_usuario`,`id_rol`) USING BTREE,
  KEY `usuariorol_rolfk2` (`id_rol`) USING BTREE,
  CONSTRAINT `usuario_rol_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usuario_rol_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usuario_rol
-- ----------------------------
INSERT INTO `usuario_rol` VALUES ('14', 'admin', 'ADMINISTRADOR');
INSERT INTO `usuario_rol` VALUES ('7', 'usuario1', 'USUARIO');
INSERT INTO `usuario_rol` VALUES ('9', 'usuario2', 'USUARIO');
INSERT INTO `usuario_rol` VALUES ('13', 'usuario3', 'USUARIO');
SET FOREIGN_KEY_CHECKS=1;
