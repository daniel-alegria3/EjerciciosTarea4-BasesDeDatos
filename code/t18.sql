--- \skiplines{1}
--- \item Relación de oficiales de crédito que hayan efectuado préstamos en todas las
--- comunidades.

--- \begin{minted}[breaklines]{sql}
WITH
R as (
    SELECT Pmo.CodOficial, COUNT(Pio.CodComunidad) as NroComunidades
    FROM Prestamo Pmo inner join Prestatario Pio on Pmo.CodPrestatario = Pio.CodPrestatario
    GROUP BY Pmo.CodOficial
    HAVING COUNT(Pio.CodComunidad) = (
        select COUNT(CodComunidad) from Comunidad
    )
)
exec cr_CompletarOficiales R;
go
--- \end{minted}

