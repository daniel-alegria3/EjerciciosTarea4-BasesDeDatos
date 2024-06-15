--- \skiplines{1}
--- \item Relación de prestatarios que hayan cancelado sus préstamos sin pagos parciales.

--- \begin{minted}[breaklines]{sql}
WITH
R as (
    SELECT P.CodPrestatario
    FROM Prestamo P left outer join Amortizacion A on P.DocPrestamo = A.DocPrestamo
    GROUP BY P.DocPrestamo
    HAVING SUM(P.Importe) = SUM(IsNull(A.Importe, 0)) and
           COUNT(A.DocCancelacion) = 1
)
exec cr_CompletarPrestatarios R;
go
--- \end{minted}

