
CREATE ROLE "larry" NOINHERIT LOGIN PASSWORD 'larry';
CREATE ROLE "sam" NOINHERIT LOGIN PASSWORD 'sam';

CREATE TABLE "public"."persona" (
  "ci" INTEGER NOT NULL, 
  "nombre_completo" VARCHAR NOT NULL, 
  "direccion" VARCHAR, 
  CONSTRAINT "persona_pkey" PRIMARY KEY("ci")
) WITH OIDS;

CREATE TABLE "public"."obrero" (
  "persona" INTEGER NOT NULL, 
  "salario" DOUBLE PRECISION, 
  "annos_exp" INTEGER, 
  "grado_esc" VARCHAR, 
  CONSTRAINT "obrero_pkey" PRIMARY KEY("persona"), 
  CONSTRAINT "obrero_fk" FOREIGN KEY ("persona")
    REFERENCES "public"."persona"("ci")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) WITH OIDS;

CREATE TABLE "public"."especialista" (
  "obrero" INTEGER NOT NULL, 
  "cargo" VARCHAR, 
  CONSTRAINT "especialista_pkey" PRIMARY KEY("obrero"), 
  CONSTRAINT "especialista_fk" FOREIGN KEY ("obrero")
    REFERENCES "public"."obrero"("persona")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) WITH OIDS;

CREATE TABLE "public"."cliente" (
  "persona" INTEGER NOT NULL, 
  "telef" VARCHAR(20), 
  CONSTRAINT "cliente_pkey" PRIMARY KEY("persona"), 
  CONSTRAINT "cliente_fk" FOREIGN KEY ("persona")
    REFERENCES "public"."persona"("ci")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) WITHOUT OIDS;

CREATE TABLE "public"."llamada" (
  "cod_llamada" INTEGER NOT NULL, 
  "cliente" INTEGER NOT NULL, 
  "telef_marcado" VARCHAR(20), 
  "fecha" DATE, 
  "hora_inicio" TIME WITHOUT TIME ZONE, 
  "hora_fin" TIME WITHOUT TIME ZONE, 
  CONSTRAINT "llamada_pkey" PRIMARY KEY("cod_llamada"), 
  CONSTRAINT "llamada_cliente_fkey" FOREIGN KEY ("cliente")
    REFERENCES "public"."cliente"("persona")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) WITHOUT OIDS;

CREATE INDEX "ifk_rel_17" ON "public"."llamada"
  USING btree ("cliente");

CREATE INDEX "llamada_fkindex1" ON "public"."llamada"
  USING btree ("cliente");    
  
  CREATE TABLE "public"."servicio_suplementario" (
  "cod_serv" INTEGER NOT NULL, 
  "descripcion" VARCHAR(255), 
  "importe" DOUBLE PRECISION, 
  CONSTRAINT "servicio_suplementario_pkey" PRIMARY KEY("cod_serv")
) WITHOUT OIDS;

CREATE TABLE "public"."cliente_servicio" (
  "servicio" INTEGER NOT NULL, 
  "cliente" INTEGER NOT NULL, 
  CONSTRAINT "cliente_servicio_pkey" PRIMARY KEY("servicio", "cliente"), 
  CONSTRAINT "cliente_servicio_cliente_fkey" FOREIGN KEY ("cliente")
    REFERENCES "public"."cliente"("persona")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE, 
  CONSTRAINT "cliente_servicio_servicio_fkey" FOREIGN KEY ("servicio")
    REFERENCES "public"."servicio_suplementario"("cod_serv")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) WITHOUT OIDS;

CREATE INDEX "cliente_has_servicio_suplementario_fkindex1" ON "public"."cliente_servicio"
  USING btree ("cliente");

CREATE INDEX "cliente_has_servicio_suplementario_fkindex2" ON "public"."cliente_servicio"
  USING btree ("servicio");

CREATE INDEX "ifk_rel_15" ON "public"."cliente_servicio"
  USING btree ("cliente");

CREATE INDEX "ifk_rel_16" ON "public"."cliente_servicio"
  USING btree ("servicio");

