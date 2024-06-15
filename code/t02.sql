--- \item Relación de préstamos efectuados por los prestatarios de una determinada
--- comunidad.
--- \begin{minted}[breaklines]{sql}
WITH
R (CodComunidad, CodPrestatario) as (
    SELECT Pio.CodComunidad, Pio.CodPrestatario
    FROM Prestatario Pio inner join Prestamo Pmo on Pio.CodPrestatario = Pmo.CodPrestatario
)
exec cr_CompletarPrestamos R;
go
--- \end{minted}

