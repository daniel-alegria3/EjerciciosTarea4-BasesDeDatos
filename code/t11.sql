--- \skiplines{1}
--- \item Relación de prestatarios que en todas las veces que solicitó un préstamo,
--- sólo una vez incurrió en mora.

--- \begin{minted}[breaklines]{sql}
WITH
R1 as (
    SELECT P.CodPrestatario, P.DocPrestamo
    FROM Prestamo P left outer join Amortizacion A on P.DocPrestamo = A.DocPrestamo
    GROUP BY P.DocPrestamo, P.CodPrestatario, P.FechaVencimiento
    HAVING SUM(IsNull(A.Importe, 0)) < SUM(P.Importe) and GetDate() > P.FechaVencimiento
),
R2 as (
    SELECT CodPrestatario
    FROM R1
    GROUP BY DocPrestamo
    HAVING COUNT(DocPrestamo) = 1
)
exec cr_CompletarPrestatarios R2;
go
--- \end{minted}

