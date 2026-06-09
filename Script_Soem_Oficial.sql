/*CREAR BASE DE DATOS Y SELECCIONARLA*/
CREATE DATABASE Soem_Oficial;
USE Soem_Oficial;

/*CREAR TODAS LAS TABLAS*/
/*TABLA ROLES*/
CREATE TABLE Roles (
  id_rol INT NOT NULL AUTO_INCREMENT,
  nombre_rol VARCHAR(45) NOT NULL,
  Descrip_rol VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_rol)
  );

/*TABLA CATEGORIA*/
CREATE TABLE Categoria (
  id_Categoria INT NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_Categoria)
  );
  
/*TABLA TIPO DE DOCUMENTO*/
CREATE TABLE TipoDocumento (
  id_TipoDocumento INT NOT NULL AUTO_INCREMENT,
  Descrip_documento VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_TipoDocumento)
  );

/*TABLA TALLA*/
CREATE TABLE Talla (
Id_Talla INT NOT NULL AUTO_INCREMENT,
  Descripcion_talla VARCHAR(100) NOT NULL,
  PRIMARY KEY (Id_Talla)
  );

/*TABLA UNIDAD*/
CREATE TABLE Unidad (
  Id_unidad INT NOT NULL AUTO_INCREMENT,
  Descripcion_unidad VARCHAR(45) NOT NULL,
  PRIMARY KEY (Id_unidad)
  );
  
/*TABLA METODO DE PAGO*/
CREATE TABLE Metododepago (
  id_metodoPago INT NOT NULL AUTO_INCREMENT,
  Descripcion_metodoPago VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_metodoPago)
  );

/*TABLA COLORES*/
CREATE TABLE Colores (
  id_nombre_color INT NOT NULL AUTO_INCREMENT,
  codigoRGB VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_nombre_color)
  );
  
  /*TABLA PERMISOS*/
CREATE TABLE Permisos (
  id_Permisos INT NOT NULL AUTO_INCREMENT,
  Descrip_permisos VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_Permisos)
  );
  
/*TABLA PRODUCTO*/
CREATE TABLE Producto (
  id_producto INT NOT NULL AUTO_INCREMENT,
  Nombre_Producto VARCHAR(45) NOT NULL,
  Descrip_Producto VARCHAR(100) NOT NULL,
  stock VARCHAR(45) NOT NULL,
  precio_producto DECIMAL(10,2) NOT NULL,
  Categoria_idCategoria INT NOT NULL,
  Talla_Id_Talla INT NOT NULL,
  Unidad_Id_unidad INT NOT NULL,
  PRIMARY KEY (id_producto),
  CONSTRAINT fk_Producto_Categoria
    FOREIGN KEY (Categoria_idCategoria)
    REFERENCES Categoria (id_Categoria),
  CONSTRAINT fk_Producto_Talla
    FOREIGN KEY (Talla_Id_Talla)
    REFERENCES Talla (Id_Talla),
  CONSTRAINT fk_Producto_Unidad
    FOREIGN KEY (Unidad_Id_unidad)
    REFERENCES Unidad (Id_unidad)
    );
 
/*TABLA USUARIO*/
CREATE TABLE Usuario (
  id_Usuario INT NOT NULL AUTO_INCREMENT,
  Nombre_Usuario VARCHAR(45) NOT NULL,
  Apellido_Usuario VARCHAR(45) NOT NULL,
  Numero_Documento VARCHAR(45) NOT NULL,
  Telefono VARCHAR(45) NOT NULL,
  correo VARCHAR(45) NOT NULL,
  Contraseña VARCHAR(45) NOT NULL,
  Direccion VARCHAR(45) NOT NULL,
  Fecha_nacimiento DATE NOT NULL,
  Fecha_vencimiento DATE NOT NULL,
  Autorizacion_datos VARCHAR(45) NOT NULL,
  Roles_id_rol INT NOT NULL,
  Producto_id_producto INT NOT NULL,
  TipoDocumento_idTipoDocumento INT NOT NULL,
  PRIMARY KEY (id_Usuario),
  CONSTRAINT fk_Usuario_Roles1
    FOREIGN KEY (Roles_id_rol)
    REFERENCES Roles (id_rol),
  CONSTRAINT fk_Usuario_Producto
    FOREIGN KEY (Producto_id_producto)
    REFERENCES Producto (id_producto),
  CONSTRAINT fk_Usuario_TipoDocumento
    FOREIGN KEY (TipoDocumento_idTipoDocumento)
    REFERENCES TipoDocumento (id_TipoDocumento)
    );

/*TABLA CABEZA FACTURA*/
CREATE TABLE Cabeza_Factura (
  id_factura INT NOT NULL AUTO_INCREMENT,
  numero_fac INT NOT NULL,
  fecha_factura DATE NOT NULL,
  tota_factura DECIMAL(10,2) NOT NULL,
  Usuario_id_usuario INT NOT NULL,
  PRIMARY KEY (id_factura),
  CONSTRAINT fk_Cabeza_Factura_Usuario
    FOREIGN KEY (Usuario_id_usuario)
    REFERENCES Usuario (id_Usuario)
    );

/*TABLA PAGOS*/
CREATE TABLE Pagos (
  id_pago INT NOT NULL AUTO_INCREMENT,
  fecha_pago DATETIME NOT NULL,
  montoPago DECIMAL(10,2) NOT NULL,
  Metododepago_id_metodoPago INT NOT NULL,
  Cabeza_Factura_id_factura INT NOT NULL,
  PRIMARY KEY (id_pago),
  CONSTRAINT fk_Pagos_Metododepago
    FOREIGN KEY (Metododepago_id_metodoPago)
    REFERENCES Metododepago (id_metodoPago),
  CONSTRAINT fk_Pagos_Cabeza_Factura
    FOREIGN KEY (Cabeza_Factura_id_factura)
    REFERENCES Cabeza_Factura (id_factura)
   );

/*TABLA PRODUCTO HAS COLORES*/
CREATE TABLE Producto_has_Colores (
  Producto_id_producto INT NOT NULL,
  Colores_id_nombre_color INT NOT NULL,
  PRIMARY KEY (Producto_id_producto, Colores_id_nombre_color),
  CONSTRAINT fk_Producto_has_Colores_Producto
    FOREIGN KEY (Producto_id_producto)
    REFERENCES Producto (id_producto),
  CONSTRAINT fk_Producto_has_Colores_Colores
    FOREIGN KEY (Colores_id_nombre_color)
    REFERENCES Colores (id_nombre_color)
    );

/*TABLA DETALLE FACTURA*/
CREATE TABLE Detalle_Factura (
  id_Detalle_Factura INT NOT NULL AUTO_INCREMENT,
  cantidad INT NOT NULL,
  subtotal_fac DECIMAL(10,2) NOT NULL,
  Cabeza_Factura_id_factura INT NOT NULL,
  Producto_id_producto INT NOT NULL,
  PRIMARY KEY (id_Detalle_Factura),
  CONSTRAINT fk_Detalle_Factura_Cabeza_Factura
    FOREIGN KEY (Cabeza_Factura_id_factura)
    REFERENCES Cabeza_Factura (id_factura),
  CONSTRAINT fk_Detalle_Factura_Producto
    FOREIGN KEY (Producto_id_producto)
    REFERENCES Producto (id_producto)
  );

/*TABLA ROLES HAS PERMISOS*/
CREATE TABLE Roles_has_Permisos (
  Roles_id_rol INT NOT NULL,
  Permisos_id_Permisos INT NOT NULL,
  PRIMARY KEY (Roles_id_rol, Permisos_id_Permisos),
  CONSTRAINT fk_Roles_has_Permisos_Roles
    FOREIGN KEY (Roles_id_rol)
    REFERENCES Roles (id_rol),
  CONSTRAINT fk_Roles_has_Permisos_Permisos
    FOREIGN KEY (Permisos_id_Permisos)
    REFERENCES Permisos (id_Permisos)
   );

/*TABLA CARRITO COMPRA*/
CREATE TABLE Carrito_Compra (
  id_Carrito INT NOT NULL AUTO_INCREMENT,
  Cantidad VARCHAR(45) NOT NULL,
  Fecha_agregado DATE NOT NULL,
  Producto_id_producto INT NOT NULL,
  PRIMARY KEY (id_Carrito),
  CONSTRAINT fk_Carrito_Compra_Producto
    FOREIGN KEY (Producto_id_producto)
    REFERENCES Producto (id_producto)
);
