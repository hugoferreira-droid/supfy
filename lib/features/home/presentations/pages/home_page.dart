import 'package:braip_clone/config/themes/app_colors.dart';
import 'package:braip_clone/features/home/presentations/pages/widgets/responsaveis_card.dart';
import 'package:braip_clone/features/home/widgets/affiliation_section.dart';
import 'package:braip_clone/features/home/widgets/delivery_section.dart';
import 'package:braip_clone/features/home/widgets/drawer_menu.dart';
import 'package:braip_clone/features/home/widgets/custom_appbar.dart';
import 'package:braip_clone/features/home/widgets/my_products_list.dart';
import 'package:braip_clone/features/home/widgets/packaging_section.dart';
import 'package:braip_clone/features/home/widgets/product_list_item.dart';
import 'package:braip_clone/features/home/widgets/product_steps_widget.dart';
import 'package:braip_clone/features/home/widgets/product_details_form_widget.dart';
import 'package:braip_clone/features/home/widgets/sales_details_section.dart';
import 'package:braip_clone/features/home/widgets/plans_section.dart';
import 'package:braip_clone/features/home/presentations/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      appBar: const CustomAppbar(),
      drawer: DrawerMenu(controller: controller),
      body: Obx(() => _buildPageContent(controller.currentPage.value)),
    );
  }

  Widget _buildPageContent(HomePageType pageType) {
    switch (pageType) {
      case HomePageType.dashboard:
        return _buildDashboard();
      case HomePageType.loja:
        return _buildLoja();
      case HomePageType.produtos:
        return _buildProdutos();
      case HomePageType.meusProdutos:
        return _buildMeusProdutos();
      case HomePageType.cadastrarProduto:
        return _buildCadastrarProduto();
      case HomePageType.streaming:
        return _buildStreaming();
      case HomePageType.afiliacoes:
        return _buildAfiliacoes();
      case HomePageType.responsaveis:
        return _buildResponsaveis();
      case HomePageType.ferramentas:
        return _buildFerramentas();
      case HomePageType.relatorios:
        return _buildRelatorios();
      case HomePageType.configuracoes:
        return _buildConfiguracoes();
    }
  }

  Widget _buildDashboard() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.dashboard, size: 64, color: Color(0xFF6B46C1)),
            onPressed: () {
              final nomeController = TextEditingController();
              final valorController = TextEditingController();
              String? formaCobranca;

              showDialog(
                context: Get.context!,
                barrierDismissible: false,
                builder: (context) {
                  return Dialog(
                    insetPadding: EdgeInsets.all(12),
                    backgroundColor: Colors.white,
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        InputDecoration baseDecoration(String hint) =>
                            InputDecoration(
                              hintText: hint,
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            );

                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Novo plano',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              const Text('Nome *'),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: nomeController,
                                decoration: baseDecoration(
                                  'Digite um nome para o novo plano',
                                ),
                              ),

                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Valor *'),
                                        const SizedBox(height: 8),
                                        TextFormField(
                                          controller: valorController,
                                          keyboardType:
                                              const TextInputType.numberWithOptions(
                                                decimal: true,
                                              ),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9.,]'),
                                            ),
                                          ],
                                          decoration: baseDecoration(
                                            'R\$ 0,00',
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          'Valor em Real brasileiro(R\$)',
                                          style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Forma de cobrança *'),
                                        const SizedBox(height: 8),
                                        DropdownButtonFormField<String>(
                                          value: formaCobranca,
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                          ),
                                          items: const [
                                            DropdownMenuItem(
                                              value: 'Credito',
                                              child: Text('Credito'),
                                            ),
                                            DropdownMenuItem(
                                              value: 'Débito',
                                              child: Text('Débito'),
                                            ),
                                          ],
                                          onChanged: (val) => setState(
                                            () => formaCobranca = val,
                                          ),
                                          decoration: baseDecoration(
                                            'Selecione...',
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: Colors.grey.shade300,
                                        ),
                                        foregroundColor: Colors.grey.shade800,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 14,
                                        ),
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Fechar'),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF6B46C1,
                                        ),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 14,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text('Adicionar plano'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.of(Get.context!).push(
                MaterialPageRoute(
                  builder: (_) => const _EmbalagemProdutoPage(),
                ),
              );
            },
            child: const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B46C1),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Bem-vindo ao seu painel principal',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildLoja() {
    final PageController pageController = PageController();
    final RxInt currentPageIndex = 0.obs;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Olá, Arthur Neves Sousa Cipriano',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Seja bem vindo!',
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color(0xFF6B46C1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.all(20),
            height: 200,
            child: Stack(
              children: [
                PageView.builder(
                  controller: pageController,
                  itemCount: 3,
                  onPageChanged: (index) {
                    currentPageIndex.value = index;
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage('assets/news.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentPageIndex.value == index
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.4),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Loja',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

   
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3, 
            itemBuilder: (context, index) {
              return ProductListItem(key: ValueKey('product_$index'));
            },
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    '< Previous',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
                const SizedBox(width: 20),
                _buildPageNumber(1, false),
                const SizedBox(width: 10),
                _buildPageNumber(2, true), 
                const SizedBox(width: 10),
                _buildPageNumber(3, false),
                const SizedBox(width: 10),
                const Text('...', style: TextStyle(color: Colors.black87)),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Next >',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProdutos() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_basket, size: 64, color: Color(0xFF6B46C1)),
          SizedBox(height: 16),
          Text(
            'Produtos',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B46C1),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Gerencie seus produtos aqui',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildMeusProdutos() {
    final PageController pageController = PageController();
    final RxInt currentPageIndex = 0.obs;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            height: 200,
            child: Stack(
              children: [
                PageView.builder(
                  controller: pageController,
                  itemCount: 3,
                  onPageChanged: (index) {
                    currentPageIndex.value = index;
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage('assets/news.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 18,
                  left: 0,
                  right: 0,
                  child: Obx(
                    () => _PageSegmentsIndicator(
                      count: 3,
                      current: currentPageIndex.value,
                      height: 4,
                      spacing: 6,
                      radius: 8,
                      paddingHorizontal: 50,
                      activeColor: Colors.black54,
                      inactiveColor: Colors.white.withOpacity(0.35),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Meus Produtos',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset('assets/open_box.png'),
                      SizedBox(width: 4),
                      const Text(
                        'Todos os produtos',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.tertiary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 2,
                          ),
                          child: Text(
                            'Novo Produto',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Por padrão o carregamento inicial do filtro busca por status.',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const Text(
                  'APROVADO, PENDENTE E AGUARDANDO ALTERAÇÃO.',
                  style: TextStyle(fontSize: 14, color: AppColors.secondary),
                ),
                Divider(color: Colors.grey.shade200, indent: 20, endIndent: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: BoxBorder.all(
                            width: 1,
                            color: Colors.grey.shade200,
                          ),
                        ),
                        child: MyProductsList(key: ValueKey('product_$index')),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    '< Previous',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
                const SizedBox(width: 20),
                _buildPageNumber(1, false),
                const SizedBox(width: 10),
                _buildPageNumber(2, true),
                const SizedBox(width: 10),
                _buildPageNumber(3, false),
                const SizedBox(width: 10),
                const Text('...', style: TextStyle(color: Colors.black87)),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Next >',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCadastrarProduto() {
    final PageController pageController = PageController();
    final RxInt currentPageIndex = 0.obs;
    final RxInt currentStep = 0.obs;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            height: 200,
            child: Stack(
              children: [
                PageView.builder(
                  controller: pageController,
                  itemCount: 3,
                  onPageChanged: (index) {
                    currentPageIndex.value = index;
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage('assets/news.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(3, (index) {
                          return Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentPageIndex.value == index
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.4),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Obx(
            () => ProductStepsWidget(
              currentStep: currentStep.value,
              onStepChanged: (stepIndex) {
                currentStep.value = stepIndex;
              },
              onContinue: () {
                if (currentStep.value < 4) {
                  currentStep.value++;
                }
              },
            ),
          ),

          Obx(() {
            switch (currentStep.value) {
              case 0:
                return ProductDetailsFormWidget(
                  onContinue: () {
                    if (currentStep.value < 4) {
                      currentStep.value++;
                    }
                  },
                );
              case 1:
                return Column(
                  children: [
                    const SalesDetailsSection(),
                    const PlansSection(),
                    _buildSalesSettingsForm(),
                  ],
                );
              case 2:
                return PackagingSection();
              case 3:
                return DeliverySection();
              case 4:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [AffiliationSection()],
                );
              default:
                return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }

  Widget _buildSalesSettingsForm() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Páginas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),

          _buildUrlField(
            label: 'URL da página de vendas',
            isRequired: true,
            initialValue: 'https://exemplo.com',
          ),

          const SizedBox(height: 20),

          _buildUrlField(
            label: 'URL da página de obrigado',
            isRequired: true,
            initialValue: 'https://exemplo.com',
          ),

          const SizedBox(height: 20),

          _buildUrlField(
            label: 'URL da página do reclame aqui',
            isRequired: false,
            initialValue: 'https://exemplo.com',
            helperText: 'Se não cadastrado, o produto não poderá ser aprovado.',
          ),

          const SizedBox(height: 20),

          _buildUrlField(
            label: 'E-mail de suporte',
            isRequired: false,
            initialValue: '',
            helperText:
                'Se não cadastrado, será usado o mesmo endereço de e-mail de seu login.',
          ),

          const SizedBox(height: 32),

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () {
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                      side: BorderSide(color: Colors.grey[300]!, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Voltar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6B46C1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Continuar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUrlField({
    required String label,
    required bool isRequired,
    required String initialValue,
    String? helperText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            if (isRequired) ...[
              const SizedBox(width: 4),
              const Text(
                '*',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF0F2F5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
        if (helperText != null) ...[
          const SizedBox(height: 4),
          Text(
            helperText,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ],
    );
  }

  Widget _buildStreaming() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.play_circle_outline, size: 64, color: Color(0xFF6B46C1)),
          SizedBox(height: 16),
          Text(
            'Streaming',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B46C1),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Conteúdo em streaming disponível',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildAfiliacoes() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people, size: 64, color: Color(0xFF6B46C1)),
          SizedBox(height: 16),
          Text(
            'Afiliações',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B46C1),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Gerencie suas afiliações',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildResponsaveis() {
    final PageController pageController = PageController();
    final RxInt currentPageIndex = 0.obs;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Olá, Arthur Neves Sousa Cipriano',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Seja bem vindo!',
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color(0xFF6B46C1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.all(20),
            height: 200,
            child: Stack(
              children: [
                PageView.builder(
                  controller: pageController,
                  itemCount: 3,
                  onPageChanged: (index) {
                    currentPageIndex.value = index;
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage('assets/news.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 18,
                  left: 0,
                  right: 0,
                  child: Obx(
                    () => _PageSegmentsIndicator(
                      count: 3,
                      current: currentPageIndex.value,
                      height: 4,
                      spacing: 6,
                      radius: 8,
                      paddingHorizontal: 50,
                      activeColor: Colors.black54,
                      inactiveColor: Colors.white.withOpacity(0.35),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Responsáveis',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ResponsaveisCard(
              onAdd: () {
                print('test F ');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFerramentas() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.build, size: 64, color: Color(0xFF6B46C1)),
          SizedBox(height: 16),
          Text(
            'Ferramentas',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B46C1),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Ferramentas disponíveis',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatorios() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bar_chart, size: 64, color: Color(0xFF6B46C1)),
          SizedBox(height: 16),
          Text(
            'Relatórios',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B46C1),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Visualize seus relatórios',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildConfiguracoes() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.settings, size: 64, color: Color(0xFF6B46C1)),
          SizedBox(height: 16),
          Text(
            'Configurações',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B46C1),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Configure suas preferências',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }


  Widget _buildPageNumber(int number, bool isActive) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF6B46C1) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive ? const Color(0xFF6B46C1) : Colors.grey[300]!,
        ),
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black87,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _PageSegmentsIndicator extends StatelessWidget {
  const _PageSegmentsIndicator({
    required this.count,
    required this.current,
    this.height = 4,
    this.spacing = 6,
    this.radius = 8,
    this.paddingHorizontal = 0,
    this.activeColor = Colors.white,
    this.inactiveColor = const Color(0x66FFFFFF),
  });

  final int count;
  final int current;
  final double height;
  final double spacing;
  final double radius;
  final double paddingHorizontal;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final totalSpacing = spacing * (count - 1);
          final maxWidth = constraints.maxWidth;
          final segWidth = ((maxWidth - totalSpacing) / count).clamp(
            0.0,
            double.infinity,
          );

          return Row(
            children: List.generate(count, (i) {
              final selected = i == current;
              return Padding(
                padding: EdgeInsets.only(right: i < count - 1 ? spacing : 0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  width: segWidth,
                  height: height,
                  decoration: BoxDecoration(
                    color: selected ? activeColor : inactiveColor,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

class _EmbalagemProdutoPage extends StatefulWidget {
  const _EmbalagemProdutoPage({Key? key}) : super(key: key);

  @override
  State<_EmbalagemProdutoPage> createState() => _EmbalagemProdutoPageState();
}

class _EmbalagemProdutoPageState extends State<_EmbalagemProdutoPage> {
  final _nomeController = TextEditingController();
  final _alturaController = TextEditingController();
  final _larguraController = TextEditingController();
  final _comprimentoController = TextEditingController();

  String _formato = 'Caixa/pacote';

  InputDecoration _decoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[600]),
      filled: true,
      fillColor: Colors.grey[200],
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _alturaController.dispose();
    _larguraController.dispose();
    _comprimentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF6B46C1);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const Text(
          'Embalagem do Produto',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black87),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Fechar',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Formato da embalagem',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: _FormatChoice(
                        label: 'Caixa/pacote',
                        selected: _formato == 'Caixa/pacote',
                        onTap: () => setState(() => _formato = 'Caixa/pacote'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: _FormatChoice(
                        label: 'Rolo/prisma',
                        selected: _formato == 'Rolo/prisma',
                        onTap: () => setState(() => _formato = 'Rolo/prisma'),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 140),
                child: Image.asset(
                  'assets/box_sizes.png',
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 16),
              const Text('Crie um nome para a embalagem'),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: TextFormField(
                  controller: _nomeController,
                  inputFormatters: [LengthLimitingTextInputFormatter(40)],
                  textAlignVertical: TextAlignVertical.center,
                  decoration: _decoration(hint: ''),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Máximo de 40 caracteres.',
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),

              const SizedBox(height: 16),
              const Text('Altura (A) *'),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: TextFormField(
                  controller: _alturaController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textAlignVertical: TextAlignVertical.center,
                  decoration: _decoration(hint: ''),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Em centímetros. Máximo 105cm e mínimo 2cm.',
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),

              const SizedBox(height: 16),
              const Text('Largura (L) *'),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: TextFormField(
                  controller: _larguraController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textAlignVertical: TextAlignVertical.center,
                  decoration: _decoration(hint: ''),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Em centímetros. Máximo 105cm e mínimo 11cm.',
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),

              const SizedBox(height: 16),
              const Text('Comprimento (C) *'),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: TextFormField(
                  controller: _comprimentoController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textAlignVertical: TextAlignVertical.center,
                  decoration: _decoration(hint: ''),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Em centímetros. Máximo 105cm e mínimo 16cm.',
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),

              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade300),
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Fechar'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        print('Formato: ' + _formato);
                        print('Nome: ' + _nomeController.text);
                        print('Altura (A): ' + _alturaController.text);
                        print('Largura (L): ' + _larguraController.text);
                        print(
                          'Comprimento (C): ' + _comprimentoController.text,
                        );
                        Navigator.of(context).pop();
                      },
                      child: const Text('Salvar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormatChoice extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FormatChoice({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF6B46C1);
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? primary : Colors.grey.shade400,
                width: 2,
              ),
            ),
            child: selected
                ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: selected ? primary : Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
