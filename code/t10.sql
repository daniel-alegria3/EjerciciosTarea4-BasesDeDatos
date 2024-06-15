--- \item Relación de prestatarios que en ninguno de sus préstamos hayan incurrido en mora.
--- \begin{minted}[breaklines]{sql}
WITH
R1 as (
    SELECT P.CodPrestatario
    FROM Prestamo P left outer join Amortizacion A on P.DocPrestamo = A.DocPrestamo
    GROUP BY P.DocPrestamo, P.CodPrestatario, P.FechaVencimiento
    HAVING SUM(IsNull(A.Importe, 0)) < SUM(P.Importe) and GetDate() > P.FechaVencimiento
),
R2 as (
    SELECT P.CodPrestatario
    FROM Prestatario P, R1
    WHERE P.CodPrestatario = R1.CodPrestatario

)
exec cr_CompletarPrestatarios R2;
go
--- \end{minted}

