# ModeloR_Viveros

## Esquema Relacional: Sistema de Gestión de Viveros

---

### 1. Vivero

- **Vivero**(`ID_Vivero` *(PK)*, `Nombre`, `Latitud`, `Longitud`)

Esta tabla almacena la información básica de los viveros, tales como su ubicación y nombre.

---

### 2. Zona

- **Zona**(`ID_Vivero` *(FK, PK)*, `ID_Zona` *(PK)*, `Nombre`, `Latitud`, `Longitud`)

Entidad débil dependiente de **Vivero**. Cada zona está asociada a un vivero y se define por su nombre y su localización dentro del vivero.

- **Claves primarias**: `ID_Vivero`, `ID_Zona`
- **Clave foránea**: `ID_Vivero` referencia a la tabla **Vivero**(`ID_Vivero`)

---

### 3. Producto

- **Producto**(`ID_Producto` *(PK)*, `Nombre`)

Esta tabla almacena los productos cultivados y vendidos por el vivero.

---

### 4. Empleado

- **Empleado**(`ID_Empleado` *(PK)*, `Nombre`)

Esta tabla contiene la información sobre los empleados que trabajan en el vivero.

---

### 5. ClienteTajinastePlus

- **ClienteTajinastePlus**(`ID_Cliente` *(PK)*, `Nombre`)

Tabla que almacena los clientes suscritos al programa "Tajinaste Plus".

---

### 6. Pedido

- **Pedido**(`ID_Pedido` *(PK)*, `Fecha_Pedido`, `ID_Cliente` *(FK)*, `ID_Empleado` *(FK)*)

Tabla para almacenar los pedidos realizados por los clientes. Cada pedido tiene asignado un cliente y un empleado responsable.

- **Claves foráneas**:
  - `ID_Cliente` referencia a la tabla **ClienteTajinastePlus**(`ID_Cliente`)
  - `ID_Empleado` referencia a la tabla **Empleado**(`ID_Empleado`)

---

### 7. Stock

- **Stock**(`ID_Vivero` *(FK, PK)*, `ID_Zona` *(FK, PK)*, `ID_Producto` *(FK, PK)*, `Cantidad`)

Relación entre **Zona** y **Producto**. Esta tabla registra el stock de productos en cada zona del vivero.

- **Claves primarias**: `ID_Vivero`, `ID_Zona`, `ID_Producto`
- **Claves foráneas**:
  - `ID_Vivero`, `ID_Zona` referencia a la tabla **Zona**(`ID_Vivero`, `ID_Zona`)
  - `ID_Producto` referencia a la tabla **Producto**(`ID_Producto`)

---

### 8. Historial_Puesto

- **Historial_Puesto**(`ID_Vivero` *(FK, PK)*, `ID_Zona` *(FK, PK)*, `ID_Empleado` *(FK, PK)*, `Fecha_Inicio`, `Fecha_Fin`, `Tarea`, `Productividad`)

Relación entre **Zona** y **Empleado**. Se utiliza para registrar el historial de las zonas en las que ha trabajado cada empleado.

- **Claves primarias**: `ID_Vivero`, `ID_Zona`, `ID_Empleado`, `Fecha_Inicio`, `Fecha_Fin`
- **Claves foráneas**:
  - `ID_Vivero`, `ID_Zona` referencia a la tabla **Zona**(`ID_Vivero`, `ID_Zona`)
  - `ID_Empleado` referencia a la tabla **Empleado**(`ID_Empleado`)

---

### 9. Detalle_Pedido

- **Detalle_Pedido**(`ID_Pedido` *(FK, PK)*, `ID_Producto` *(FK, PK)*, `Cantidad`)

Relación entre **Pedido** y **Producto**. Almacena los productos y las cantidades que forman parte de cada pedido.

- **Claves primarias**: `ID_Pedido`, `ID_Producto`
- **Claves foráneas**:
  - `ID_Pedido` referencia a la tabla **Pedido**(`ID_Pedido`)
  - `ID_Producto` referencia a la tabla **Producto**(`ID_Producto`)

---

### Restricciones Adicionales

1. **Empleado no puede trabajar en más de una zona al mismo tiempo**:  
   Restricción sobre la tabla **Historial_Puesto**, donde debe existir una diferencia entre `Fecha_Inicio` y `Fecha_Fin` para cada registro de un mismo empleado, evitando que esté asignado simultáneamente a más de una zona.

2. **El stock de productos no puede ser negativo**:  
   Restricción en la tabla **Stock**: la columna `Cantidad` debe ser mayor o igual a 0.  
   ```sql
   CHECK (Cantidad >= 0)

3. **El pedido no puede superar el stock disponible**:
   Antes de confirmar un pedido, se debe validar que la cantidad solicitada de un producto en la tabla Detalle_Pedido no exceda la         cantidad disponible en la tabla Stock. Esto puede implementarse mediante un trigger o lógica de la aplicación.
    ```sql
    CHECK (Cantidad <= (SELECT Cantidad FROM Stock WHERE Stock.ID_Producto = Detalle_Pedido.ID_Producto AND Stock.ID_Zona = Detalle_Pedido.ID_Zona))

