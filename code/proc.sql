use DBCreditoRural;
go
set dateformat dMy
go

--[[[ LIMPIAR ]]]
DROP PROCEDURE IF EXISTS cr_CompletarComunidades;
DROP PROCEDURE IF EXISTS cr_CompletarPrestatarios;
DROP PROCEDURE IF EXISTS cr_CompletarPrestamos;
DROP PROCEDURE IF EXISTS cr_CompletarOficiales;
DROP TYPE IF EXISTS TTablaComunidades;
DROP TYPE IF EXISTS TTablaPrestatarios;
DROP TYPE IF EXISTS TTablaPrestamos;
DROP TYPE IF EXISTS TTablaOficiales;
go

--[[[ TYPOS ]]]
CREATE TYPE TTablaComunidades AS TABLE (CodComunidad TCodComunidad)
CREATE TYPE TTablaPrestatarios AS TABLE (CodPrestatario TCodPrestatario)
CREATE TYPE TTablaPrestamos AS TABLE (DocPrestamo TDocPrestamo)
CREATE TYPE TTablaOficiales AS TABLE (CodOficial TCodOficial)
go

--[[[ PORCEDIMIENTOS ]]]
CREATE PROCEDURE cr_CompletarComunidades @TablaComunidades TTablaComunidades READONLY
AS
BEGIN
    select T.*, C.Nombre as NombreComunidad
    from Comunidad C inner join @TablaComunidades T
    on P.CodComunidad = T.CodComunidad
END;

CREATE PROCEDURE cr_CompletarPrestatarios @TablaPrestatarios TTablaPrestatarios READONLY
AS
BEGIN
    select T.*, P.Nombres as NombresPrestatario, P.DocIdentidad as DocIdentidadPrestatario, P.CodComunidad
    from Prestatario P inner join @TablaPrestatarios T
    on P.CodPrestatario = T.CodPrestatario
END;

CREATE PROCEDURE cr_CompletarPrestamos @TablaPrestamos TTablaPrestamos READONLY
AS
BEGIN
    select T.*, P.CodPrestatario, P.Importe as ImportePrestamo, P.FechaVencimiento, P.CodComunidad
    from Prestamo P inner join @TablaPrestamos T
    on P.DocPrestamo = T.DocPrestamo
END;

CREATE PROCEDURE cr_CompletarOficiales @TablaOficiales TTablaOficiales READONLY
AS
BEGIN
    select T.*, O.Nombres as NombreOficial, O.Email as EmailOficial
    from Oficial O inner join @TablaOficiales T
    on O.CodOficial = T.CodOficial
END;

-- exec proc_Procedimiento table

