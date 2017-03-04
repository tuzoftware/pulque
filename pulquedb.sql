/*
Navicat MySQL Data Transfer

Source Server         : local3306
Source Server Version : 50505
Source Host           : 127.0.0.1:3306
Source Database       : pulque

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2017-03-03 18:10:35
*/

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
-- Table structure for test_continente
-- ----------------------------
DROP TABLE IF EXISTS `test_continente`;
CREATE TABLE `test_continente` (
  `id_test_continente` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `continente` varchar(255) NOT NULL,
  PRIMARY KEY (`id_test_continente`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of test_continente
-- ----------------------------
INSERT INTO `test_continente` VALUES ('1', 'America');
INSERT INTO `test_continente` VALUES ('2', 'Africa');
INSERT INTO `test_continente` VALUES ('3', 'Europa');
INSERT INTO `test_continente` VALUES ('4', 'Asia');
INSERT INTO `test_continente` VALUES ('5', 'Oceania');

-- ----------------------------
-- Table structure for test_pais
-- ----------------------------
DROP TABLE IF EXISTS `test_pais`;
CREATE TABLE `test_pais` (
  `id_test_pais` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_test_continente` int(11) unsigned NOT NULL,
  `pais` varchar(255) NOT NULL,
  PRIMARY KEY (`id_test_pais`),
  KEY `test_pais_fk1` (`id_test_continente`),
  CONSTRAINT `test_pais_fk1` FOREIGN KEY (`id_test_continente`) REFERENCES `test_continente` (`id_test_continente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of test_pais
-- ----------------------------
INSERT INTO `test_pais` VALUES ('1', '1', 'México');
INSERT INTO `test_pais` VALUES ('3', '1', 'Argentina');
INSERT INTO `test_pais` VALUES ('4', '1', 'Canada');
INSERT INTO `test_pais` VALUES ('5', '1', 'Chile');
INSERT INTO `test_pais` VALUES ('6', '1', 'Brasil');
INSERT INTO `test_pais` VALUES ('8', '1', 'Belice');
INSERT INTO `test_pais` VALUES ('9', '1', 'Guatemala');
INSERT INTO `test_pais` VALUES ('10', '2', 'Angola');
INSERT INTO `test_pais` VALUES ('11', '2', 'Argelía');
INSERT INTO `test_pais` VALUES ('12', '2', 'Benin');
INSERT INTO `test_pais` VALUES ('13', '3', 'España');
INSERT INTO `test_pais` VALUES ('14', '3', 'Inglaterra');
INSERT INTO `test_pais` VALUES ('15', '3', 'Francia');
INSERT INTO `test_pais` VALUES ('16', '3', 'Alemania');
INSERT INTO `test_pais` VALUES ('17', '4', 'China');
INSERT INTO `test_pais` VALUES ('18', '4', 'India');
INSERT INTO `test_pais` VALUES ('19', '5', 'Australia');
INSERT INTO `test_pais` VALUES ('20', '5', 'Japon');

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
INSERT INTO `usuario` VALUES ('admin', '5f4dcc3b5aa765d61d8327deb882cf99', 'SI', 'NO', '2017-03-02 21:36:42', '0', 'NO', null);
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
