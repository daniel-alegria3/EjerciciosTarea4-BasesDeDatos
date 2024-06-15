--- \item Relación de comunidades cuyos prestatarios que aún tienen saldos, no hayan
--- efectuado ninguna amortización en lo que va del año 2004.
--- \begin{minted}[breaklines]{sql}
WITH
R1 (CodPrestatario) as (
    SELECT P.CodPrestatario, P.DocPrestamo
    FROM Prestamo P left outer join Amortizacion A on P.DocPrestamo = A.DocPrestamo
    WHERE DATEPART(year, A.FechaCancelacion) = 2004
    GROUP BY P.DocPrestamo
    HAVING (SUM(P.Importe) > SUM(IsNull(A.Importe, 0)))
),
R2 (CodComunidad) as (
    SELECT P.CodComunidad
    FROM Prestatario P left outer join R1 on P.CodPrestatario = R1.DocPrestamo
)
exec cr_CompletarComunidades R2;
go
--- \end{minted}

