--- \item Relación de las 5 comunidades que tienen el mayor número de prestatarios.
--- \begin{minted}[breaklines]{sql}
WITH
R (CodComunidad, NroPrestatarios) as (
    SELECT TOP(5) C.CodComunidad, COUNT(P.CodPrestatario) as NroPrestatarios
    FROM Comunidad C inner join Prestatario P on C.CodComunidad = P.CodComunidad
    GROUP BY C.CodComunidad
    ORDER BY NroPrestatarios DESC
)
exec cr_CompletarComunidades R
go
--- \end{minted}

