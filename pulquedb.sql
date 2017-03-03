/*
Navicat MySQL Data Transfer

Source Server         : local3306
Source Server Version : 50505
Source Host           : 127.0.0.1:3306
Source Database       : bd

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2017-03-03 16:43:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for convocatoria
-- ----------------------------
DROP TABLE IF EXISTS `convocatoria`;
CREATE TABLE `convocatoria` (
  `id_convocatoria` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_programa` int(11) unsigned NOT NULL,
  `mes` tinyint(2) NOT NULL,
  `anio` smallint(4) NOT NULL,
  `ruta_imagen` varchar(255) DEFAULT NULL,
  `fecha_inicio_capacitacion` date NOT NULL,
  `fecha_fin_capacitacion` date NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `estatus` varchar(20) NOT NULL DEFAULT 'ACTIVO',
  PRIMARY KEY (`id_convocatoria`),
  KEY `convocatoria_fk1` (`id_programa`),
  CONSTRAINT `convocatoria_fk1` FOREIGN KEY (`id_programa`) REFERENCES `programa` (`id_programa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of convocatoria
-- ----------------------------

-- ----------------------------
-- Table structure for curso
-- ----------------------------
DROP TABLE IF EXISTS `curso`;
CREATE TABLE `curso` (
  `id_curso` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `horas` mediumint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_curso`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of curso
-- ----------------------------
INSERT INTO `curso` VALUES ('69', 'Curso TEST', 'recursos_externos/recursos/curso/id_curso/img/bd.png', '0');

-- ----------------------------
-- Table structure for curso_usuario
-- ----------------------------
DROP TABLE IF EXISTS `curso_usuario`;
CREATE TABLE `curso_usuario` (
  `id_curso_usuario` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_usuario` varchar(64) NOT NULL,
  `porcentaje` int(10) unsigned zerofill NOT NULL,
  `habilitado` char(2) NOT NULL DEFAULT 'NO',
  `id_programa_detalle` int(10) unsigned DEFAULT NULL,
  `completado` char(2) NOT NULL DEFAULT 'NO',
  PRIMARY KEY (`id_curso_usuario`),
  KEY `usuario_curo_fk2` (`id_usuario`),
  KEY `curso_usuario_fk1` (`id_programa_detalle`),
  CONSTRAINT `curso_usuario_fk1` FOREIGN KEY (`id_programa_detalle`) REFERENCES `programa_detalle` (`id_programa_detalle`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `curso_usuario_fk2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of curso_usuario
-- ----------------------------
INSERT INTO `curso_usuario` VALUES ('8', 'usuario1', '0000000075', 'SI', '69', 'NO');
INSERT INTO `curso_usuario` VALUES ('9', 'usuario2', '0000000025', 'SI', '69', 'NO');
INSERT INTO `curso_usuario` VALUES ('10', 'usuario3', '0000000000', 'SI', '69', 'NO');

-- ----------------------------
-- Table structure for examen
-- ----------------------------
DROP TABLE IF EXISTS `examen`;
CREATE TABLE `examen` (
  `id_examen` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_curso_usuario` int(10) unsigned NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `calificacion` decimal(10,0) unsigned NOT NULL DEFAULT '0',
  `tipo_examen` varchar(255) NOT NULL DEFAULT '' COMMENT 'TEMARIO,UNIDAD,CURSO',
  `id_temario_unidad_curso` int(11) NOT NULL,
  PRIMARY KEY (`id_examen`),
  KEY `examen_fk1` (`id_curso_usuario`) USING BTREE,
  CONSTRAINT `examen_fk1` FOREIGN KEY (`id_curso_usuario`) REFERENCES `curso_usuario` (`id_curso_usuario`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of examen
-- ----------------------------
INSERT INTO `examen` VALUES ('78', '8', '2016-04-03 17:08:37', '100', 'TEMARIO', '45');
INSERT INTO `examen` VALUES ('79', '9', '2016-04-03 17:08:41', '50', 'TEMARIO', '45');
INSERT INTO `examen` VALUES ('80', '8', '2016-04-03 17:08:41', '100', 'TEMARIO', '45');
INSERT INTO `examen` VALUES ('81', '9', '2016-04-03 17:09:05', '100', 'TEMARIO', '45');
INSERT INTO `examen` VALUES ('82', '8', '2016-04-03 17:09:22', '50', 'TEMARIO', '47');
INSERT INTO `examen` VALUES ('83', '9', '2016-04-03 17:09:18', '0', 'TEMARIO', '49');
INSERT INTO `examen` VALUES ('84', '8', '2016-04-20 21:42:42', '100', 'TEMARIO', '47');
INSERT INTO `examen` VALUES ('85', '8', '2016-04-21 16:04:13', '0', 'TEMARIO', '50');
INSERT INTO `examen` VALUES ('86', '8', '2016-08-08 14:35:50', '0', 'TEMARIO', '50');
INSERT INTO `examen` VALUES ('87', '8', '2016-08-09 17:36:04', '0', 'TEMARIO', '50');
INSERT INTO `examen` VALUES ('88', '8', '2016-12-07 23:30:26', '0', 'TEMARIO', '50');

-- ----------------------------
-- Table structure for examen_cerrado
-- ----------------------------
DROP TABLE IF EXISTS `examen_cerrado`;
CREATE TABLE `examen_cerrado` (
  `id_examen_cerrado` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_curso_usuario` int(10) unsigned NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `calificacion` decimal(10,0) unsigned NOT NULL DEFAULT '0',
  `intento` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_examen_cerrado`),
  KEY `examen_fk1` (`id_curso_usuario`) USING BTREE,
  CONSTRAINT `examen_cerrado_ibfk_1` FOREIGN KEY (`id_curso_usuario`) REFERENCES `curso_usuario` (`id_curso_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of examen_cerrado
-- ----------------------------
INSERT INTO `examen_cerrado` VALUES ('1', '10', '2017-02-27 13:42:06', '0', '0');

-- ----------------------------
-- Table structure for examen_cerrado_respuesta
-- ----------------------------
DROP TABLE IF EXISTS `examen_cerrado_respuesta`;
CREATE TABLE `examen_cerrado_respuesta` (
  `id_examen_respuesta_cerrada` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_plantilla_examen` int(11) unsigned NOT NULL,
  `pregunta` varchar(255) NOT NULL,
  `respuesta` varchar(255) NOT NULL,
  PRIMARY KEY (`id_examen_respuesta_cerrada`),
  KEY `examen_prog_fk1` (`id_plantilla_examen`),
  CONSTRAINT `examen_prog_fk1` FOREIGN KEY (`id_plantilla_examen`) REFERENCES `examen_plantilla` (`id_plantilla_examen`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of examen_cerrado_respuesta
-- ----------------------------
INSERT INTO `examen_cerrado_respuesta` VALUES ('27', '13', 'dddddddd', 'ddddd');
INSERT INTO `examen_cerrado_respuesta` VALUES ('28', '13', 'eerrrrrrrrrrrrrr', 'eeeee');

-- ----------------------------
-- Table structure for examen_cerrado_resultado
-- ----------------------------
DROP TABLE IF EXISTS `examen_cerrado_resultado`;
CREATE TABLE `examen_cerrado_resultado` (
  `id_examen_resultado_cerrado` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_examen_respuesta_cerrada` int(11) unsigned NOT NULL,
  `id_examen_cerrado` int(11) unsigned NOT NULL,
  `respuesta_contestada` varchar(255) NOT NULL,
  `es_correcta` char(2) NOT NULL COMMENT '"SI" "NO"',
  PRIMARY KEY (`id_examen_resultado_cerrado`),
  KEY `final_contestada_fk1` (`id_examen_respuesta_cerrada`),
  KEY `final_contestada_fk2` (`id_examen_cerrado`),
  CONSTRAINT `final_contestada_fk1` FOREIGN KEY (`id_examen_respuesta_cerrada`) REFERENCES `examen_cerrado_respuesta` (`id_examen_respuesta_cerrada`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `final_contestada_fk2` FOREIGN KEY (`id_examen_cerrado`) REFERENCES `examen_cerrado` (`id_examen_cerrado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of examen_cerrado_resultado
-- ----------------------------

-- ----------------------------
-- Table structure for examen_detalle
-- ----------------------------
DROP TABLE IF EXISTS `examen_detalle`;
CREATE TABLE `examen_detalle` (
  `id_examen_detalle` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_examen` int(10) unsigned NOT NULL,
  `id_respuesta_contestada` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_examen_detalle`),
  KEY `examen_detalle_fk1` (`id_examen`) USING BTREE,
  KEY `examen_detalle_fk2` (`id_respuesta_contestada`) USING BTREE,
  CONSTRAINT `examen_detalle_ibfk_1` FOREIGN KEY (`id_examen`) REFERENCES `examen` (`id_examen`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `examen_detalle_ibfk_2` FOREIGN KEY (`id_respuesta_contestada`) REFERENCES `examen_respuesta` (`id_respuesta`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of examen_detalle
-- ----------------------------

-- ----------------------------
-- Table structure for examen_plantilla
-- ----------------------------
DROP TABLE IF EXISTS `examen_plantilla`;
CREATE TABLE `examen_plantilla` (
  `id_plantilla_examen` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_temario` int(11) unsigned NOT NULL,
  `tipo_examen` varchar(255) NOT NULL DEFAULT 'Avance' COMMENT '"Avance,Ultimo"',
  PRIMARY KEY (`id_plantilla_examen`),
  KEY `examen_plntilla` (`id_temario`),
  CONSTRAINT `examen_plntilla` FOREIGN KEY (`id_temario`) REFERENCES `temario` (`id_temario`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of examen_plantilla
-- ----------------------------
INSERT INTO `examen_plantilla` VALUES ('13', '45', 'Abierto');

-- ----------------------------
-- Table structure for examen_pregunta
-- ----------------------------
DROP TABLE IF EXISTS `examen_pregunta`;
CREATE TABLE `examen_pregunta` (
  `id_pregunta` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_plantilla_examen` int(10) unsigned NOT NULL,
  `pregunta` varchar(500) NOT NULL,
  PRIMARY KEY (`id_pregunta`),
  KEY `examen_pregunta_fk1` (`id_plantilla_examen`) USING BTREE,
  CONSTRAINT `examen_pregunta_ibfk_1` FOREIGN KEY (`id_plantilla_examen`) REFERENCES `examen_plantilla` (`id_plantilla_examen`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of examen_pregunta
-- ----------------------------

-- ----------------------------
-- Table structure for examen_respuesta
-- ----------------------------
DROP TABLE IF EXISTS `examen_respuesta`;
CREATE TABLE `examen_respuesta` (
  `id_respuesta` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_pregunta` int(11) unsigned NOT NULL,
  `respuesta` varchar(255) NOT NULL,
  `correcta` char(2) NOT NULL DEFAULT 'NO',
  `imagen` blob,
  PRIMARY KEY (`id_respuesta`),
  KEY `examen_respuesta_fk1` (`id_pregunta`) USING BTREE,
  CONSTRAINT `examen_respuesta_ibfk_1` FOREIGN KEY (`id_pregunta`) REFERENCES `examen_pregunta` (`id_pregunta`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of examen_respuesta
-- ----------------------------

-- ----------------------------
-- Table structure for herramienta
-- ----------------------------
DROP TABLE IF EXISTS `herramienta`;
CREATE TABLE `herramienta` (
  `id_herramienta` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `tipo` varchar(255) NOT NULL,
  `nombre_comprimido` varchar(255) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id_herramienta`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of herramienta
-- ----------------------------
INSERT INTO `herramienta` VALUES ('1', 'eclipse keepler', 'IDE', 'eclipse.rar', 'r', 'http://google.com');
INSERT INTO `herramienta` VALUES ('2', 'Eclipse Neon', 'IDE', 'eclipse.kepler.rar', 'rr', 'dd.rar');
INSERT INTO `herramienta` VALUES ('3', 'hhh', 'IDE', 'hhh.zip', 'r', 'ddd');
INSERT INTO `herramienta` VALUES ('4', 'hhh', 'IDE', 'hhh.zip', 'r', '');
INSERT INTO `herramienta` VALUES ('5', 'jjjj', 'IDE', 'jjjj.zip', 'r', '');
INSERT INTO `herramienta` VALUES ('6', 'jjjj', 'IDE', 'jjjj.zip', 'r', '');
INSERT INTO `herramienta` VALUES ('7', 'dd', 'IDE', 'ddd.zip', 'r', '');
INSERT INTO `herramienta` VALUES ('8', 'dd', 'IDE', 'ddd.zip', 'r', '');
INSERT INTO `herramienta` VALUES ('9', 'dd', 'IDE', 'ddd.zip', 'r', '');
INSERT INTO `herramienta` VALUES ('10', 'ff', 'IDE', 'fff.zip', '', '');
INSERT INTO `herramienta` VALUES ('11', 'ff', 'IDE', 'fff.zip', '', '');
INSERT INTO `herramienta` VALUES ('12', '12', 'IDE', '123', '', '');
INSERT INTO `herramienta` VALUES ('13', 'ggg', 'Oo', 'ggg.zip', '', '');
INSERT INTO `herramienta` VALUES ('14', 'ff', 'IDE', 'ffff.zip', '', '');
INSERT INTO `herramienta` VALUES ('15', 'cc', 'IDE', 'ccc', '', '/matrix/utileria/ide/ccc');
INSERT INTO `herramienta` VALUES ('16', 'ijk', 'IDE', 'kkkk', '', '/matrix/utileria/ide/kkkk');
INSERT INTO `herramienta` VALUES ('17', 'mmm', 'Oo', 'mm', '', '/matrix/utileria/oo/mm');
INSERT INTO `herramienta` VALUES ('18', 'jj', 'IDE', 'jjj', '', '/matrix/utileria/ide/jjj');
INSERT INTO `herramienta` VALUES ('19', 'kk', 'IDE', 'kkk', '', '/matrix/utileria/ide/kkk');
INSERT INTO `herramienta` VALUES ('20', 'hhh', 'IDE', 'hhhhh', '', '/matrix/utileria/ide/hhhhh');
INSERT INTO `herramienta` VALUES ('21', 'jj', 'IDE', 'jjjj', '', '/matrix/utileria/ide/jjjj');
INSERT INTO `herramienta` VALUES ('22', 'dd', 'IDE', 'ddd', '', '/matrix/utileria/ide/ddd');
INSERT INTO `herramienta` VALUES ('23', 'rrrr', 'IDE', 'rr', '', '/matrix/utileria/ide/rr');
INSERT INTO `herramienta` VALUES ('24', 'ff', 'IDE', 'ff', '', '/matrix/utileria/ide/ff');
INSERT INTO `herramienta` VALUES ('25', 'dd', 'IDE', 'dddd', '', '/matrix/utileria/ide/dddd');
INSERT INTO `herramienta` VALUES ('26', 'lk', 'IDE', 'lll', '', '/matrix/utileria/ide/lll');
INSERT INTO `herramienta` VALUES ('27', 'mm', 'IDE', 'mmmm', '', '/matrix/utileria/ide/mmmm');
INSERT INTO `herramienta` VALUES ('28', 'mmmm', 'IDE', 'mmmm', '', '/matrix/utileria/ide/mmmm');

-- ----------------------------
-- Table structure for inscripcion
-- ----------------------------
DROP TABLE IF EXISTS `inscripcion`;
CREATE TABLE `inscripcion` (
  `id_inscripcion` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_convoctoria` int(11) unsigned NOT NULL,
  `id_usuario` varchar(64) NOT NULL,
  PRIMARY KEY (`id_inscripcion`),
  KEY `inscripcion_fk1` (`id_convoctoria`),
  KEY `inscripcion_fk2` (`id_usuario`),
  CONSTRAINT `inscripcion_fk1` FOREIGN KEY (`id_convoctoria`) REFERENCES `convocatoria` (`id_convocatoria`),
  CONSTRAINT `inscripcion_fk2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of inscripcion
-- ----------------------------

-- ----------------------------
-- Table structure for permiso
-- ----------------------------
DROP TABLE IF EXISTS `permiso`;
CREATE TABLE `permiso` (
  `id_permiso` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_rol` varchar(255) NOT NULL,
  `permiso` varchar(255) NOT NULL,
  PRIMARY KEY (`id_permiso`),
  UNIQUE KEY `rol_id_permiso` (`id_rol`,`permiso`) USING BTREE,
  CONSTRAINT `permiso_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of permiso
-- ----------------------------
INSERT INTO `permiso` VALUES ('2', 'ADMINISTRADOR', 'ADMINISTRADOR');
INSERT INTO `permiso` VALUES ('1', 'ALUMNO', 'ALUMNO');

-- ----------------------------
-- Table structure for programa
-- ----------------------------
DROP TABLE IF EXISTS `programa`;
CREATE TABLE `programa` (
  `id_programa` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) NOT NULL,
  PRIMARY KEY (`id_programa`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of programa
-- ----------------------------
INSERT INTO `programa` VALUES ('69', 'Test');

-- ----------------------------
-- Table structure for programa_detalle
-- ----------------------------
DROP TABLE IF EXISTS `programa_detalle`;
CREATE TABLE `programa_detalle` (
  `id_programa_detalle` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_programa` int(10) unsigned NOT NULL,
  `id_curso` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_programa_detalle`),
  KEY `programa_detalle_curso_fk1` (`id_curso`) USING BTREE,
  KEY `programa_detalle_programa_fk2` (`id_programa`) USING BTREE,
  CONSTRAINT `programa_detalle_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `programa_detalle_ibfk_2` FOREIGN KEY (`id_programa`) REFERENCES `programa` (`id_programa`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of programa_detalle
-- ----------------------------
INSERT INTO `programa_detalle` VALUES ('69', '69', '69');

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
INSERT INTO `rol` VALUES ('ALUMNO', 'alumno');

-- ----------------------------
-- Table structure for temario
-- ----------------------------
DROP TABLE IF EXISTS `temario`;
CREATE TABLE `temario` (
  `id_temario` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_unidad` int(10) unsigned NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `url_video` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_temario`),
  KEY `temario_unidad_fk1` (`id_unidad`) USING BTREE,
  CONSTRAINT `temario_ibfk_2` FOREIGN KEY (`id_unidad`) REFERENCES `unidad` (`id_unidad`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of temario
-- ----------------------------
INSERT INTO `temario` VALUES ('45', '4', 'Tema 1', 't');
INSERT INTO `temario` VALUES ('47', '4', 'Tema 2', 'tt');
INSERT INTO `temario` VALUES ('49', '4', 'Tema 3', 'fff');

-- ----------------------------
-- Table structure for unidad
-- ----------------------------
DROP TABLE IF EXISTS `unidad`;
CREATE TABLE `unidad` (
  `id_unidad` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_curso` int(10) unsigned NOT NULL,
  `nombre` varchar(250) NOT NULL,
  `url_video` varchar(255) NOT NULL,
  PRIMARY KEY (`id_unidad`),
  KEY `unidad_curso_fk1` (`id_curso`) USING BTREE,
  CONSTRAINT `unidad_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of unidad
-- ----------------------------
INSERT INTO `unidad` VALUES ('4', '69', 'Unidad pruebas 2', '');
INSERT INTO `unidad` VALUES ('5', '69', 'ddddd', '');
INSERT INTO `unidad` VALUES ('6', '69', 'fffff dddd', '');
INSERT INTO `unidad` VALUES ('7', '69', 'pruebas', 'recursos_externos/recursos/curso/69/video/rec17_01_2017_08_17_11.mp4');
INSERT INTO `unidad` VALUES ('8', '69', 'rrrrrrrrr', 'recursos_externos/recursos/curso/69/video/rec18_01_2017_04_33_41.mp4');
INSERT INTO `unidad` VALUES ('9', '69', 'rrrrrrr', 'recursos_externos/recursos/curso/69/video/rec18_01_2017_04_44_38.mp4');
INSERT INTO `unidad` VALUES ('10', '69', 'rrrrrrrrrrrrrreeeeeeeee', 'recursos_externos/recursos/curso/69/video/rec18_01_2017_04_49_29.mp4');
INSERT INTO `unidad` VALUES ('11', '69', 'dddddfffffffffffffffff', 'recursos_externos/recursos/curso/69/video/rec18_01_2017_04_51_25.mp4');

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
INSERT INTO `usuario` VALUES ('', '', 'SI', 'NO', null, '0', 'NO', null);
INSERT INTO `usuario` VALUES ('f3rch0', '3e4bc99ad773c48a415b3f8e8954f2c1', 'SI', 'SI', '2017-02-27 12:49:36', '0', 'NO', null);
INSERT INTO `usuario` VALUES ('usuario1', '5f4dcc3b5aa765d61d8327deb882cf99', 'SI', 'NO', '2016-12-08 09:50:00', '0', 'NO', null);
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
INSERT INTO `usuario_datos` VALUES ('f3rch0', 'eeeeeeeeee', 'eeeeeeeeeeee', 'eeaaaaaaaaaaa', 'Hombre', '2017-01-05', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usuario_rol
-- ----------------------------
INSERT INTO `usuario_rol` VALUES ('16', 'f3rch0', 'ADMINISTRADOR');
INSERT INTO `usuario_rol` VALUES ('7', 'usuario1', 'ALUMNO');
INSERT INTO `usuario_rol` VALUES ('9', 'usuario2', 'ALUMNO');
INSERT INTO `usuario_rol` VALUES ('13', 'usuario3', 'ALUMNO');
