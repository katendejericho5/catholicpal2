import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckInboxScreen extends StatelessWidget {
  const CheckInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(flex: 2),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: SvgPicture.string(
                    checkInboxIllistration,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const Spacer(flex: 2),
              ErrorInfo(
                title: "Empty Inbox",
                description:
                    "Your inbox is empty. Please check back later or refresh to see new emails.",
                // button: you can pass your custom button,
                btnText: "Refresh",
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorInfo extends StatelessWidget {
  const ErrorInfo({
    super.key,
    required this.title,
    required this.description,
    this.button,
    this.btnText,
    required this.press,
  });

  final String title;
  final String description;
  final Widget? button;
  final String? btnText;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16 * 2.5),
            button ??
                ElevatedButton(
                  onPressed: press,
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                  child: Text(btnText ?? "Retry".toUpperCase()),
                ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

const checkInboxIllistration = '''
<svg width="1080" height="1080" viewBox="0 0 1080 1080" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M886.31 544.13H920.31C923.493 544.13 926.545 545.394 928.795 547.645C931.046 549.895 932.31 552.947 932.31 556.13V906.13C932.31 909.313 931.046 912.365 928.795 914.615C926.545 916.866 923.493 918.13 920.31 918.13H570.31C567.127 918.13 564.075 916.866 561.825 914.615C559.574 912.365 558.31 909.313 558.31 906.13V872.13C558.31 785.139 592.867 701.711 654.379 640.199C715.891 578.687 799.319 544.13 886.31 544.13Z" fill="#D3D3D3"/>
<path d="M283.23 241.71C291.084 241.71 297.45 235.344 297.45 227.49C297.45 219.637 291.084 213.27 283.23 213.27C275.377 213.27 269.01 219.637 269.01 227.49C269.01 235.344 275.377 241.71 283.23 241.71Z" fill="#E2E2E2"/>
<path d="M265.74 303.61C275.399 303.61 283.23 295.779 283.23 286.12C283.23 276.461 275.399 268.63 265.74 268.63C256.081 268.63 248.25 276.461 248.25 286.12C248.25 295.779 256.081 303.61 265.74 303.61Z" fill="#E2E2E2"/>
<path d="M324.31 292.4C330.871 292.4 336.19 287.081 336.19 280.52C336.19 273.959 330.871 268.64 324.31 268.64C317.749 268.64 312.43 273.959 312.43 280.52C312.43 287.081 317.749 292.4 324.31 292.4Z" fill="#E2E2E2"/>
<path d="M478.87 575.69V355.37C478.87 327.86 439.77 310.05 406.78 322.54C390.04 328.88 379.55 341.7 379.7 355.66L379.91 375.44L380.62 441.61" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M597.08 302.76L420.83 318.47" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M479.52 575.69L745.35 509.25V346.69C745.35 317.12 721.47 292.87 686.85 294.76L620.79 300.65" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M629.81 300.74V256.69L664.81 253.19V227.69H605.31L606.08 302.76L609.31 471.19L634.93 467.68L629.81 300.74Z" fill="#ABABAB"/>
<path d="M620.81 300.74V256.69L655.81 253.19V227.69H596.31L597.08 302.76L600.31 471.19L625.93 467.68L620.81 300.74Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M584.1 549.29V917.23" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M604.54 545.02V917.23" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M638.77 537.89V917.23" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M395.614 876.636C423.519 858.776 431.663 821.676 413.803 793.77C395.942 765.865 358.842 757.721 330.937 775.582C303.031 793.442 294.888 830.542 312.748 858.447C330.608 886.353 367.708 894.496 395.614 876.636Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M341.241 850.764C340 851.562 338.718 851.817 337.395 851.529C336.05 851.208 334.979 850.427 334.181 849.186C333.383 847.944 333.128 846.662 333.416 845.339C333.682 843.983 334.435 842.906 335.677 842.108C336.918 841.31 338.211 841.072 339.555 841.393C340.878 841.68 341.938 842.445 342.736 843.686C343.534 844.927 343.8 846.226 343.534 847.583C343.247 848.905 342.482 849.966 341.241 850.764ZM354.314 842.36C353.072 843.158 351.79 843.413 350.467 843.126C349.123 842.804 348.052 842.023 347.254 840.782C346.456 839.541 346.201 838.259 346.488 836.936C346.754 835.579 347.508 834.502 348.749 833.704C349.99 832.906 351.283 832.668 352.628 832.989C353.951 833.276 355.011 834.041 355.809 835.282C356.607 836.524 356.873 837.822 356.607 839.179C356.319 840.502 355.555 841.562 354.314 842.36ZM367.386 833.956C366.145 834.754 364.863 835.009 363.54 834.722C362.196 834.401 361.124 833.619 360.326 832.378C359.528 831.137 359.273 829.855 359.561 828.532C359.827 827.176 360.58 826.098 361.822 825.3C363.063 824.502 364.356 824.264 365.7 824.585C367.023 824.873 368.084 825.637 368.882 826.878C369.68 828.12 369.946 829.419 369.68 830.775C369.392 832.098 368.627 833.158 367.386 833.956Z" fill="#0E0E0E"/>
<path d="M901.32 412.93C910.98 412.93 918.81 405.1 918.81 395.44C918.81 385.781 910.98 377.95 901.32 377.95C891.661 377.95 883.83 385.781 883.83 395.44C883.83 405.1 891.661 412.93 901.32 412.93Z" fill="#E2E2E2"/>
<path d="M248.986 780.368C256.309 777.529 259.944 769.292 257.105 761.97C254.266 754.647 246.029 751.012 238.706 753.851C231.384 756.69 227.749 764.927 230.588 772.25C233.426 779.572 241.664 783.207 248.986 780.368Z" fill="#E2E2E2"/>
<path d="M190.472 686.144C199.478 682.652 203.949 672.521 200.457 663.514C196.966 654.508 186.834 650.037 177.828 653.529C168.822 657.02 164.351 667.152 167.842 676.158C171.334 685.165 181.466 689.635 190.472 686.144Z" fill="#E2E2E2"/>
<path d="M184.12 559.92L156.81 554.91" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M211.49 599.6L201.61 622.79" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M170.46 591.1L146.81 611.19" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M417.93 286.12L429.29 258.44" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M388.37 286.12L383.83 272.28" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M448.4 292.4L464.88 280.52" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M467.79 452.02H296.38V566.29H467.79V452.02Z" fill="#D3D3D3"/>
<path d="M458.38 442.12H286.97V558.21H458.38V442.12Z" stroke="#231F20" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M286.97 442.12L369.58 525.23L458.38 442.12" stroke="#231F20" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M458.38 558.21L401.51 495.35" stroke="#231F20" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M286.97 558.21L341.35 496.82" stroke="#231F20" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M477.08 558.41H254.29C253.301 558.41 252.5 559.211 252.5 560.2V574.89C252.5 575.879 253.301 576.68 254.29 576.68H477.08C478.069 576.68 478.87 575.879 478.87 574.89V560.2C478.87 559.211 478.069 558.41 477.08 558.41Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''';
