#Permite visualizar os databases existentes
show databases;

#Cria um database
create database db_videolocadora_manha_20231;

#Ativa a utilização do database
use db_videolocadora_manha_20231;

#Permite apagar um database
drop database db_videolocadora_manha_20231;

#TABELA: CLASSIFICAÇÃO
create table tbl_classificacao (
	id int not null auto_increment primary key,
    sigla varchar(2) not null,
    nome varchar(80) not null,
    descricao varchar(200) not null,
    
    unique index(id)
    
);

#TABELA: SEXO
create table tbl_sexo (
	id int not null auto_increment primary key,
    sigla varchar(5) not null,
    nome varchar(45) not null,
    
    unique index(id)
);

#TABELA: GENERO
create table tbl_genero(
	id int not null auto_increment primary key,
    nome varchar(45) not null,
    
    unique index(id)
);

create table tbl_nacionalidade (
	id int not null auto_increment primary key,
    nome varchar(45) not null,
    
    unique index(id)
);

#Permite visualizar as tabelas existentes
show tables;

#Apaga uma tabela no database
drop table tbl_genero;

#Verificar a estrutura de uma tabela    
desc tbl_genero;
describe tbl_genero;    

######## VARIAÇÕES DO COMANDO ALTER TABLE ########
# add column - adiciona uma nova coluna na tabela
alter table tbl_genero
	add column descricao varchar(100) not null;
    
alter table tbl_genero
	add column teste varchar(10),
    add column tipo varchar(2);
    
#drop column - apaga uma coluna da tabela
alter table tbl_genero
	drop column teste;

#Modify column - modifica a estrutura de dados de uma coluna  
alter table tbl_genero
	modify column tipo varchar(5);
        
#Change - permite alterar o nome do atributo e a sua estrutura        
alter table tbl_genero
	change tipo tipo_genero varchar(5);

#########################################################

#CRIANDO TABELAS COM CHAVES ESTRANGEIRAS

#TABELA: Filme
create table tbl_filme (
	id int not null auto_increment primary key,
    nome varchar(100) not null,
    nome_original varchar(100),
    data_lancamento date not null,
    data_relancamento date,
    duracao time not null,
    sinopse text not null,
    foto_capa varchar(150) not null,
    id_classificacao int not null,
    
    #Cria um nome para representar a FK
    constraint FK_Classificacao_Filme
    
    #Indica quem será o atrubito desta tabela que será uma FK
    foreign key(id_classificacao)
    
    #Indica de onde virá a PK para virar a FK
    references tbl_classificacao(id),
    
    unique index(id)
);

#TABELA: FILME_GENERO
create table tbl_filme_genero(
	id int not null auto_increment,
    id_filme int not null,
    id_genero int not null,
    
    #Relacionamento Filme_FilmeGenero
    constraint FK_Filme_FilmeGenero
    foreign key(id_filme)
    references tbl_filme(id),
    
    #Relacionamento genero_FilmeGenero
    constraint FK_Genero_FilmeGenero
    foreign key(id_genero)
    references tbl_genero(id),
    
    primary key(id),
    unique index(id)

);
#TABELA: diretor
create table tbl_diretor(
	id int not null auto_increment primary key,
    nome varchar(100) not null,
    nome_artistico varchar(100),
    data_nascimento date not null,
    biografia text not null,
    foto varchar(150) not null,
    data_falecimento date,
    id_sexo int not null,
    
    constraint FK_Sexo_Diretor
    foreign key (id_sexo)
    references tbl_sexo(id),
    
    unique index(id)
);

#TABELA: DIRETOR_NACIONALIDADE
create table tbl_diretor_nacionalidade(
	id int not null auto_increment primary key,
    id_diretor int not null,
    id_nacionalidade int not null,
    
    #Relacionamento Diretor_DiretorNacionalidade
    constraint FK_Diretor_DiretorNacionalidade
    foreign key(id_diretor)
    references tbl_diretor(id),
    
    #Relacionamento Nacionalidade_DiretorNacionalidade
    constraint FK_Nacionalidade_DiretorNacionalidade
    foreign key(id_nacionalidade)
    references tbl_nacionalidade(id),
    
    unique index(id)
);

#TABELA: FILME_DIRETOR
create table tbl_filme_diretor(
	id int not null auto_increment primary key,
    id_filme int not null,
    id_diretor int not null,
    
    #Relacionamento Filme_FilmeDiretor
    constraint FK_Filme_FilmeDiretor
    foreign key(id_filme)
    references tbl_filme(id),
    
    #Relacionamento Diretor_FilmeDiretor
    constraint FK_Diretor_FilmeDiretor
    foreign key(id_diretor)
    references tbl_diretor(id),
    
    unique index(id)
);

#TABELA: ATOR
create table tbl_ator(
	id int not null auto_increment primary key,
    nome varchar(100) not null,
    nome_artistico varchar(100),
    data_nascimento date not null,
    biografia text not null,
    foto varchar(150) not null,
    id_sexo int not null,
    
    constraint FK_Sexo_Ator
    foreign key (id_sexo)
    references tbl_sexo(id),
    
    unique index(id)
);

#add column - adicionando atributo data_falecimento na tabela ator
alter table tbl_ator
	add column data_falecimento date;

#TABELA: FILME_ATOR    
create table tbl_filme_ator(
	id int not null auto_increment primary key,
    id_filme int not null,
    id_ator int not null,
    
    #Relacionamento Filme_FilmeAtor
    constraint FK_Filme_FilmeAtor
    foreign key(id_filme)
    references tbl_filme(id),
    
    #Relacionamento Ator_FilmeAtor
    constraint FK_Ator_FilmeAtor
    foreign key(id_ator)
    references tbl_ator(id),
    
    unique index(id)
);

#TABELA: ATOR_NACIONALIDADE  
create table tbl_ator_nacionalidade(
	id int not null auto_increment primary key,
    id_ator int not null,
    id_nacionalidade int not null,
    
    #Relacionamento Ator_AtorNacionalidade
    constraint FK_Ator_AtorNacionalidade
    foreign key(id_ator)
    references tbl_ator(id),
    
    #Relacionamento Nacionalidade_AtorNacionalidade
    constraint FK_Nacionalidade_AtorNacionalidade
    foreign key(id_nacionalidade)
    references tbl_nacionalidade(id),
    
    unique index(id)
);     

show tables;

desc tbl_ator_nacionalidade;

drop table tbl_filme;

#Drop foreing ley - Exclui uma constraint
	#(Para conseguir modificar a estrutura do atributo ou da tabela)
alter table tbl_filme_genero
	drop foreign key FK_Filme_FilmeGenero;
    
#Add constraint - adiciona uma nova constraint e sua relação     
alter table tbl_filme_genero
	add constraint FK_Filme_FilmeGenero
    foreign key(id_filme)
    references tbl_filme (id);
    
show tables;






    
    
    



