-- CreateTable
CREATE TABLE "departments" (
    "department_id" INT8 NOT NULL,
    "department_name" STRING(50) NOT NULL,

    CONSTRAINT "departments_pkey" PRIMARY KEY ("department_id")
);

-- CreateTable
CREATE TABLE "employees" (
    "employee_id" INT8 NOT NULL,
    "first_name" STRING(50),
    "last_name" STRING(50),
    "department_id" INT8,
    "role_id" INT8,
    "hire_date" DATE,
    "email" STRING(100),

    CONSTRAINT "employees_pkey" PRIMARY KEY ("employee_id")
);

-- CreateTable
CREATE TABLE "roles" (
    "role_id" INT8 NOT NULL,
    "role_name" STRING(50) NOT NULL,
    "salary" DECIMAL(10,2) NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("role_id")
);

-- CreateTable
CREATE TABLE "users" (
    "user_id" INT8 NOT NULL DEFAULT unique_rowid(),
    "email" STRING(100) NOT NULL,
    "hashed_password" STRING(255),
    "oauth_provider" STRING(50),
    "oauth_id" STRING(100),
    "full_name" STRING(100),
    "remember_me" BOOL DEFAULT false,
    "created_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "users_pkey" PRIMARY KEY ("user_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "employees_email_key" ON "employees"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- AddForeignKey
ALTER TABLE "employees" ADD CONSTRAINT "employees_department_id_fkey" FOREIGN KEY ("department_id") REFERENCES "departments"("department_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "employees" ADD CONSTRAINT "employees_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "roles"("role_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
