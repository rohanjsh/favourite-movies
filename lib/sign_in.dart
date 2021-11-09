import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  final Function(String? email, String? password)? onSubmitted;

  const LoginPage({this.onSubmitted, Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email, password;
  String? emailError, passwordError;
  Function(String? email, String? password)? get onSubmitted =>
      widget.onSubmitted;

  @override
  void initState() {
    super.initState();
    email = "";
    password = "";

    emailError = null;
    passwordError = null;
  }

  void resetErrorText() {
    setState(() {
      emailError = null;
      passwordError = null;
    });
  }

  bool validate() {
    resetErrorText();

    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    bool isValid = true;
    if (email.isEmpty || !emailExp.hasMatch(email)) {
      setState(() {
        emailError = "Email is invalid";
      });
      isValid = false;
    }

    if (password.isEmpty) {
      setState(() {
        passwordError = "Please enter a password";
      });
      isValid = false;
    }

    return isValid;
  }

  void submit() {
    if (validate()) {
      if (onSubmitted != null) {
        onSubmitted!(email, password);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network('https://i.ibb.co/260c4fS/image.png'),
                    Row(
                      children: [
                        const Text(
                          "Sign in",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.login_sharp),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SimpleTextField(
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      labelText: "Email",
                      errorText: emailError,
                      textInputAction: TextInputAction.next,
                      autoFocus: true,
                    ),
                    SizedBox(height: screenHeight * .02),
                    SimpleTextField(
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      labelText: "Password",
                      errorText: passwordError,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .07,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SimpleOutlinedButton(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => TimeLines()));
                              submit();
                            },
                            outlineColor: Colors.black,
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: screenHeight * .15,
                    // ),
                    SizedBox(height: screenHeight * .10),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wifi_calling_3,
                      size: 14,
                    ),
                    Text(
                      ' Contact us',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class SimpleOutlinedButton extends StatelessWidget {
  const SimpleOutlinedButton(
      {this.child,
      this.textColor,
      this.outlineColor,
      required this.onPressed,
      this.borderRadius = 26,
      this.padding = const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
      Key? key})
      : super(key: key);
  final Widget? child;
  final Function? onPressed;
  final double borderRadius;
  final Color? outlineColor;
  final Color? textColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: padding,
        textStyle:
            TextStyle(color: currentTheme.primaryColor, fontFamily: 'Poppins'),
        side: BorderSide(
            color: outlineColor ?? currentTheme.primaryColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        primary: textColor ?? outlineColor ?? currentTheme.primaryColor,
      ),
      onPressed: onPressed as void Function()?,
      child: child!,
    );
  }
}

class SimpleTextField extends StatefulWidget {
  const SimpleTextField(
      {this.onChanged,
      this.textEditingController,
      this.autofillHints,
      this.textInputType,
      this.autoFocus = false,
      this.obscureText = false,
      this.textInputAction,
      this.focusNode,
      this.prefixIconData,
      this.hintText,
      this.labelText,
      this.errorText,
      this.helperText,
      this.showLabelAboveTextField = false,
      this.floatingLabelBehavior = FloatingLabelBehavior.auto,
      this.fillColor,
      this.accentColor = Colors.black,
      this.textColor = Colors.black,
      this.borderRadius = 6,
      this.validator,
      this.showConfirmation = true,
      this.showError = true,
      this.verticalPadding = 20,
      this.horizontalPadding = 12,
      Key? key})
      : super(key: key);

  final Function(String)? onChanged;
  final TextEditingController? textEditingController;
  final Iterable<String>? autofillHints;
  final TextInputType? textInputType;
  final bool autoFocus;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final IconData? prefixIconData;
  final String? hintText;
  final String? labelText;
  final String? errorText;

  /// Text placed below the text field
  final String? helperText;
  final bool showLabelAboveTextField;
  final FloatingLabelBehavior floatingLabelBehavior;
  final Color? fillColor;
  final Color? accentColor;
  final Color textColor;
  final double borderRadius;
  final bool Function(String)? validator;
  final bool showConfirmation;
  final bool showError;
  final double verticalPadding;
  final double horizontalPadding;

  @override
  _SimpleTextFieldState createState() => _SimpleTextFieldState();
}

class _SimpleTextFieldState extends State<SimpleTextField> {
  late FocusNode focusNode;
  late TextEditingController textEditingController;
  late bool hasConfirmation;
  late bool hasError;
  late bool hasFocus;

  @override
  void initState() {
    super.initState();
    hasFocus = false;
    textEditingController =
        widget.textEditingController ?? TextEditingController();
    // hasConfirmation = textEditingController.text != null ? isValid : false;
    hasConfirmation = isValid;
    // hasError = textEditingController != null ? !isValid : false;
    hasError = !isValid;
    focusNode = widget.focusNode ?? FocusNode();

    focusNode.addListener(() {
      setState(() {
        hasFocus = focusNode.hasPrimaryFocus;
        bool valid = isValid;
        hasConfirmation = valid;
        hasError = !valid;
      });
    });
  }

  bool get isValid {
    if (hasValidator) {
      return widget.validator!(textEditingController.text);
    }
    return false;
  }

  bool get hasValidator {
    return widget.validator != null;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);

    OutlineInputBorder buildFocusedBorder() {
      if (hasValidator) {
        if (hasConfirmation && widget.showConfirmation) {
          return OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green, width: 1.25),
              borderRadius: BorderRadius.circular(widget.borderRadius));
        } else if (hasError) {
          return OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.25),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          );
        }
      }
      return OutlineInputBorder(
        borderSide: BorderSide(
            color: widget.accentColor ?? currentTheme.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      );
    }

    OutlineInputBorder buildEnabledBorder() {
      if (hasValidator) {
        if (hasConfirmation) {
          return OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          );
        } else if (hasError) {
          return OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          );
        }
      }
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderSide: BorderSide(
          color: Colors.grey[400]!,
        ),
      );
    }

    TextStyle? buildLabelStyle() {
      if (hasFocus) {
        return TextStyle(color: widget.accentColor);
      } else {
        return null;
      }
    }

    Icon? buildSuffixIcon() {
      if (hasValidator) {
        if (hasConfirmation) {
          return const Icon(Icons.check, color: Colors.green);
        } else if (hasError) {
          return const Icon(
            Icons.error,
            color: Colors.red,
            size: 24,
          );
        }
      }
      return null;
    }

    return TextSelectionTheme(
      data: TextSelectionThemeData(
        selectionColor: widget.accentColor?.withOpacity(.33) ??
            currentTheme.primaryColor.withOpacity(.33),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null && widget.showLabelAboveTextField) ...[
            Text(
              widget.labelText!,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: hasFocus ? currentTheme.primaryColor : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 6),
          ],
          TextField(
            focusNode: focusNode,
            controller: textEditingController,
            autofillHints: widget.autofillHints,
            keyboardType: widget.textInputType,
            autofocus: widget.autoFocus,
            onChanged: (val) {
              setState(() {
                hasError = false;
                hasConfirmation = isValid;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(val);
              }
            },
            style: TextStyle(color: widget.textColor),
            cursorColor: widget.textColor,
            obscureText: widget.obscureText,
            textInputAction: widget.textInputAction,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: widget.verticalPadding,
                  horizontal: widget.horizontalPadding),
              isDense: true,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: widget.textColor.withOpacity(.45)),
              labelText:
                  widget.showLabelAboveTextField ? null : widget.labelText,
              labelStyle: buildLabelStyle(),
              errorText: widget.errorText != null && hasError && hasValidator
                  ? widget.errorText
                  : null,
              floatingLabelBehavior: widget.floatingLabelBehavior,
              fillColor: widget.fillColor,
              filled: widget.fillColor != null,
              focusedBorder: buildFocusedBorder(),
              enabledBorder: buildEnabledBorder(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              prefixIcon: widget.prefixIconData != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 8),
                      child: Icon(
                        widget.prefixIconData,
                        color: hasFocus
                            ? widget.accentColor
                            : widget.textColor.withOpacity(.6),
                        size: 20,
                      ),
                    )
                  : null,
              prefixIconConstraints:
                  const BoxConstraints(minHeight: 24, minWidth: 24),
              suffixIcon: buildSuffixIcon(),
            ),
          ),
          if (widget.helperText != null) ...[
            const SizedBox(height: 6),
            Text(
              widget.helperText!,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            )
          ]
        ],
      ),
    );
  }
}
