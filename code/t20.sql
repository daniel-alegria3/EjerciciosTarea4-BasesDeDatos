--- \skiplines{1}
--- \item Calcular el índice de morosidad por comunidad. El índice de morosidad es
--- igual al porcentaje del saldo del préstamo que esta en riesgo sobre el total
--- del préstamo.

--- \begin{minted}[breaklines]{sql}
WITH
Q1 as (
    SELECT P.CodPrestatario, (SUM(P.Importe) - SUM(IsNull(A.Importe, 0))) as SaldoMoroso
    FROM Prestamo P left outer join Amortizacion A on P.DocPrestamo = A.DocPrestamo
    GROUP BY P.DocPrestamo, P.CodPrestatario, P.FechaVencimiento
    HAVING SUM(IsNull(A.Importe, 0)) < SUM(P.Importe) and GetDate() > P.FechaVencimiento
),
Q2 as (
    SELECT P.CodPrestatario, (SUM(P.Importe) - SUM(IsNull(A.Importe, 0))) as Saldo
    FROM Prestamo P left outer join Amortizacion A on P.DocPrestamo = A.DocPrestamo
    GROUP BY P.DocPrestamo, P.CodPrestatario, P.FechaVencimiento
),
Q3 as (
    SELECT Q1.CodPrestatario, SaldoMoroso, Saldo
    FROM Q1 left outer join Q2 on Q1.CodPrestatario = Q2.CodPrestatario
),

R as (
    SELECT P.CodComunidad, SUM(SaldoMoroso)/SUM(Saldo) as IndiceMorosidad
    FROM Prestatario P left outer join Q3 on P.CodPrestatario = Q3.CodPrestatario
    GROUP BY P.CodComunidad
)

exec cr_CompletarComunidades R;
go
--- \end{minted}

