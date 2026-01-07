CREATE (:Genero)<-[:GENERO]-(`Blinding Lights`:Musica)-[:DE_ARTISTA]->(`The Weeknd`:Artista)<-[:DE_ARTISTA]-(Starboy:Musica)-[:GENERO]->(:Genero),
(`Lewis Capaldi`:Artista)<-[:SEGUE {Desde: 2021}]-(`João`:Usuario)-[:ESCUTOU {Vezes: 32}]->(`Someone You Loved`:Musica)-[:GENERO]->(Pop:Genero)<-[:GENERO]-(`Shape of You`:Musica)-[:DE_ARTISTA]->(`Ed Sheeran`:Artista)<-[:DE_ARTISTA]-(Perfect:Musica)-[:GENERO]->(Pop),
(:Genero)<-[:GENERO]-(`Sweater Weather`:Musica)-[:DE_ARTISTA]->(`The Neighbourhood`:Artista)<-[:SEGUE {Desde: 2009}]-(Carlos:Usuario),
(Carlos)-[:SEGUE {Desde: 2010}]->(`Harry Styles`:Artista)<-[:SEGUE {Desde: 2026}]-(Francisco:Usuario)-[:SEGUE {Desde: 2008}]->(`Ed Sheeran`)<-[:SEGUE {Desde: 2012}]-(Luiz:Usuario)-[:ESCUTOU {Vezes: 55}]->(Stay:Musica)<-[:ESCUTOU {Vezes: 47}]-(Lucas:Usuario)-[:ESCUTOU {Vezes: 12}]->(`Someone You Loved`)-[:DE_ARTISTA]->(`Lewis Capaldi`)<-[:SEGUE {Desde: 2025}]-(Lucas)-[:SEGUE {Desde: 2014}]->(`Justin Bieber`:Artista),
(`The Kid LAROI`:Artista)<-[:SEGUE {Desde: 2007}]-(Luiz)-[:SEGUE {Desde: 2005}]->(`Justin Bieber`)-[:PARTICIPACAO_DE]->(Stay)-[:GENERO]->(Pop)<-[:GENERO]-(`As It Was`:Musica)-[:DE_ARTISTA]->(`Harry Styles`),
(Sunflower:Musica)<-[:ESCUTOU {Vezes: 39}]-(Pedro:Usuario)-[:ESCUTOU {Vezes: 71}]->(`One Dance`:Musica)-[:GENERO]->(:Genero)<-[:GENERO]-(Sunflower)-[:DE_ARTISTA]->(`Post Malone`:Artista)<-[:SEGUE {Desde: 2022}]-(Ana:Usuario),
(`Blinding Lights`)<-[:ESCUTOU {Vezes: 100}]-(`Antônio`:Usuario)-[:ESCUTOU {`Vezes 51`: ""}]->(`One Dance`)-[:DE_ARTISTA]->(Drake:Artista)<-[:SEGUE {Desde: 2000}]-(Pedro),
(Stay)-[:DE_ARTISTA]->(`The Kid LAROI`)<-[:SEGUE {Desde: 2013}]-(Lucas),
(Maria:Usuario)-[:SEGUE {Desde: 2023}]->(`The Weeknd`)<-[:SEGUE {Desde: 2010}]-(`João`)-[:ESCUTOU {Vezes: 34}]->(Starboy)<-[:ESCUTOU {Vezes: 10}]-(Maria)-[:ESCUTOU {Vezes: 50}]->(`Blinding Lights`),
(Luiz)-[:ESCUTOU {Vezes: 38}]->(`Shape of You`)<-[:ESCUTOU {Vezes: 27}]-(`José`:Usuario)-[:SEGUE {Desde: 2004}]->(`Ed Sheeran`),
(`Post Malone`)<-[:SEGUE]-(Pedro)-[:SEGUE {Desde: 2017}]->(:Artista)-[:PARTICIPACAO_DE]->(Sunflower)<-[:ESCUTOU {Vezes: 23}]-(Ana)-[:SEGUE {Desde: 2023}]->(`The Neighbourhood`),
(`José`)-[:ESCUTOU {Vezes: 44}]->(Perfect)<-[:ESCUTOU {Vezes: 67}]-(Francisco),
(Francisco)-[:ESCUTOU {Vezes: 4}]->(`As It Was`)<-[:ESCUTOU {Vezes: 31}]-(Carlos),
(Carlos)-[:ESCUTOU {Vezes: 25}]->(`Sweater Weather`)<-[:ESCUTOU {Vezes: 9}]-(Ana),
(`The Weeknd`)<-[:SEGUE {Desde: 1990}]-(`Antônio`)-[:SEGUE {Desde: 2002}]->(Drake)

// --- CONSULTAS DE RECOMENDAÇÃO (REQUISITO DA ATIVIDADE) ---

// 1. Recomendar músicas do mesmo artista que o usuário segue
// Lógica: Sugere faixas de um artista que o usuário segue, mas ainda não ouviu.
MATCH (u:Usuario)-[:SEGUE]->(a:Artista)<-[:DE_ARTISTA]-(m:Musica)
WHERE NOT (u)-[:ESCUTOU]->(m)
RETURN u.caption AS Ouvinte, m.caption AS Sugestao_por_Artista;

// 2. Recomendar por similaridade de gênero
// Lógica: Sugere músicas do mesmo gênero que o usuário ouviu com alta frequência (mais de 30 vezes).
MATCH (u:Usuario)-[e:ESCUTOU]->(m1:Musica)-[:GENERO]->(g:Genero)<-[:GENERO]-(m2:Musica)
WHERE e.Vezes > 30 AND NOT (u)-[:ESCUTOU]->(m2)
RETURN u.caption AS Ouvinte, m2.caption AS Sugestao_por_Genero, g.caption AS Estilo;