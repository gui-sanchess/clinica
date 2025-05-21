<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clínica Saúde Total - Login</title>

    <!-- TailwindCSS e FontAwesome -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/login.css">
</head>
<body class="min-h-screen flex flex-col md:flex-row">
<!-- Lado esquerdo -->
<div class="w-full md:w-1/2 gradient-bg text-white flex flex-col items-center justify-center p-8 md:p-12 lg:p-20">
    <div class="max-w-md text-center">
        <div class="flex items-center justify-center mb-8">
            <i class="fas fa-heartbeat text-4xl mr-3"></i>
            <h1 class="text-3xl font-bold">Clínica Saúde Total</h1>
        </div>
        <img src="https://img.freepik.com/free-vector/doctor-concept-illustration_114360-1515.jpg"
             alt="Médicos" class="w-full h-auto max-w-xs mx-auto floating">
        <h2 class="text-2xl font-semibold mt-8 mb-4">Bem-vindo de volta!</h2>
        <p class="text-white/90 mb-6">Acesse sua conta para gerenciar pacientes, agendamentos e prontuários médicos com segurança e facilidade.</p>
        <div class="flex flex-wrap justify-center gap-4 mt-8">
            <div class="bg-white/10 p-3 rounded-lg flex items-center">
                <i class="fas fa-user-md mr-2"></i><span>Profissionais</span>
            </div>
            <div class="bg-white/10 p-3 rounded-lg flex items-center">
                <i class="fas fa-calendar-check mr-2"></i><span>Agendamentos</span>
            </div>
            <div class="bg-white/10 p-3 rounded-lg flex items-center">
                <i class="fas fa-lock mr-2"></i><span>Segurança</span>
            </div>
        </div>
    </div>
</div>

<!-- Lado direito - Login -->
<div class="w-full md:w-1/2 flex items-center justify-center p-8 md:p-12 lg:p-20 bg-white">
    <div class="w-full max-w-md">
        <h2 class="text-2xl font-bold text-gray-800 mb-1">Faça login</h2>
        <p class="text-gray-600 mb-8">Use suas credenciais para acessar o sistema</p>

        <form id="loginForm" action="loginAction" method="post" class="space-y-6">
            <div>
                <label for="email" class="block text-sm font-medium text-gray-700 mb-1">E-mail profissional</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fas fa-envelope text-gray-400"></i>
                    </div>
                    <input type="text" id="email" name="email" required
                           class="pl-10 input-focus w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none"
                           placeholder="seu@email.com">
                </div>
            </div>

            <div>
                <label for="senha" class="block text-sm font-medium text-gray-700 mb-1">Senha</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fas fa-lock text-gray-400"></i>
                    </div>
                    <input type="password" id="senha" name="senha" required
                           class="pl-10 input-focus w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none"
                           placeholder="••••••••">
                </div>
            </div>

            <button type="submit"
                    class="w-full bg-blue-600 text-white py-3 px-4 rounded-lg font-medium hover:bg-blue-700 transition duration-300 flex items-center justify-center pulse-animation">
                <i class="fas fa-sign-in-alt mr-2"></i> Entrar
            </button>
        </form>
    </div>
</div>
</body>
</html>