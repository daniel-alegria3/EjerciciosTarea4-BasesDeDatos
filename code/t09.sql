--- \item Relación de comunidades con 3 de sus prestatarios más importantes (los
--- prestatarios más importantes son los que han obtenido mayor número de
--- préstamos).
--- \begin{minted}[breaklines]{sql}
WITH
R1 (CodComunidad, CodPrestatario, NroPrestamos) as (
    -- Contar el Nro de prestamos por prestatario
    SELECT Pio.CodComunidad, Pio.CodPrestatario, COUNT(Pmo.DocPrestamo) as NroPrestamos
    FROM Prestatario Pio left outer join Prestamo Pmo on Pio.CodPrestatario = Pmo.CodPrestatario
    GROUP BY Pio.CodPrestatario
    ORDER BY NroPrestamos DESC
),
R2 (CodComunidad, NombreComunidad, CodPrestatario) as (
    -- Seleccionar los los top 3 prestatarios por comunidad
    SELECT CodComunidad, C.Nombre as NombreComunidad, P.CodPrestatario
    FROM Prestatario P inner join Comunidad C on P.CodComunidad = C.CodComunidad
    WHERE CodPrestatario IN (
        select top(3) CodPrestatario from R1
        where R1.CodComunidad = P.CodComunidad
        order by NroPrestamos desc
    )
    GROUP BY CodComunidad DESC
)
exec cr_CompletarPrestatarios R2;
go
--- \end{minted}

