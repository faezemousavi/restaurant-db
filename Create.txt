-- Table: public."Agreements"

-- DROP TABLE public."Agreements";

CREATE TABLE public."Agreements"
(
    "ACode" integer NOT NULL,
    "CCode" integer NOT NULL,
    "PCode" integer NOT NULL,
    "ADate" date,
    "AReserveDate" date,
    "AReserveTurn" character(10) COLLATE pg_catalog."default",
    "ACost" integer,
    CONSTRAINT "Agreements_pkey" PRIMARY KEY ("ACode"),
    CONSTRAINT "CCode" FOREIGN KEY ("CCode")
        REFERENCES public.customers (ccode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "PCode" FOREIGN KEY ("PCode")
        REFERENCES public."Personels" ("PCode") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."Agreements"
    OWNER to postgres;
-- Table: public."Bills"

-- DROP TABLE public."Bills";

CREATE TABLE public."Bills"
(
    bcode integer NOT NULL,
    pcode integer NOT NULL,
    bdate date,
    "CAcode" integer NOT NULL,
    bcost integer,
    CONSTRAINT "Bills_pkey" PRIMARY KEY (bcode),
    CONSTRAINT "CAcode" FOREIGN KEY ("CAcode")
        REFERENCES public."Cashiers" ("CAcode") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT pcode FOREIGN KEY (pcode)
        REFERENCES public."Personels" ("PCode") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."Bills"
    OWNER to postgres;
-- Table: public."Cashiers"

-- DROP TABLE public."Cashiers";

CREATE TABLE public."Cashiers"
(
    "CAcode" integer NOT NULL,
    "CAname" character(40) COLLATE pg_catalog."default",
    "CAfamily" character(40) COLLATE pg_catalog."default",
    CONSTRAINT "Cashiers_pkey" PRIMARY KEY ("CAcode")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."Cashiers"
    OWNER to postgres;
-- Table: public."Personels"

-- DROP TABLE public."Personels";

CREATE TABLE public."Personels"
(
    "PCode" integer NOT NULL,
    "PName" character(40) COLLATE pg_catalog."default",
    "PFamily" character(40) COLLATE pg_catalog."default",
    "PAele" character(40) COLLATE pg_catalog."default",
    CONSTRAINT "Personels_pkey" PRIMARY KEY ("PCode")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."Personels"
    OWNER to postgres;
-- Table: public.customers

-- DROP TABLE public.customers;

CREATE TABLE public.customers
(
    ccode integer NOT NULL,
    cname character(40) COLLATE pg_catalog."default",
    cfamily character(40) COLLATE pg_catalog."default",
    ccm character(15) COLLATE pg_catalog."default",
    caddress character(100) COLLATE pg_catalog."default",
    cphone character(15) COLLATE pg_catalog."default",
    CONSTRAINT customers_pkey PRIMARY KEY (ccode)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.customers
    OWNER to postgres;
-- Table: public.foods

-- DROP TABLE public.foods;

CREATE TABLE public.foods
(
    fcode integer NOT NULL,
    fname character(40) COLLATE pg_catalog."default",
    fcost integer,
    fdescription character(100) COLLATE pg_catalog."default",
    CONSTRAINT foods_pkey PRIMARY KEY (fcode)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.foods
    OWNER to postgres;
-- Table: public."order_Agreement"

-- DROP TABLE public."order_Agreement";

CREATE TABLE public."order_Agreement"
(
    "OAcode" integer NOT NULL,
    "ACode" integer NOT NULL,
    "FCode" integer NOT NULL,
    "Number" integer,
    CONSTRAINT "order_Agreement_pkey" PRIMARY KEY ("OAcode"),
    CONSTRAINT "ACode" FOREIGN KEY ("ACode")
        REFERENCES public."Agreements" ("ACode") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FCode" FOREIGN KEY ("FCode")
        REFERENCES public.foods (fcode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."order_Agreement"
    OWNER to postgres;
-- Table: public.order_bills

-- DROP TABLE public.order_bills;

CREATE TABLE public.order_bills
(
    "OBcode" integer NOT NULL,
    "BCode" integer NOT NULL,
    "FCode" integer NOT NULL,
    "Number" integer,
    CONSTRAINT order_bills_pkey PRIMARY KEY ("OBcode"),
    CONSTRAINT "BCode" FOREIGN KEY ("BCode")
        REFERENCES public."Bills" (bcode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FCode" FOREIGN KEY ("FCode")
        REFERENCES public.foods (fcode) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.order_bills
    OWNER to postgres;
