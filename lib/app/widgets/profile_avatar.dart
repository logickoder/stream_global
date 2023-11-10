import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.size,
    this.url,
    this.borderColor,
    this.isFile = false,
  });

  final String? url;
  final double? size;
  final Color? borderColor;
  final bool isFile;

  @override
  Widget build(BuildContext context) {
    return size != null
        ? _Avatar(
            url: url,
            size: size!,
            borderColor: borderColor,
            isFile: isFile,
          )
        : LayoutBuilder(
            builder: (_, constraints) => _Avatar(
              url: url,
              size: constraints.maxWidth,
              borderColor: borderColor,
              isFile: isFile,
            ),
          );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.url,
    required this.size,
    required this.borderColor,
    required this.isFile,
  });

  final String? url;
  final double size;
  final Color? borderColor;
  final bool isFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor ?? Theme.of(context).colorScheme.inversePrimary,
          width: _borderSize,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size),
        child: url != null
            ? isFile
                ? Image(
                    image: FileImage(File(url!)),
                    fit: BoxFit.cover,
                    width: size,
                    height: size,
                  )
                : CachedNetworkImage(
                    imageUrl: url!,
                    fit: BoxFit.cover,
                    width: size,
                    height: size,
                  )
            : Icon(Icons.person, size: size - (_borderSize * 2)),
      ),
    );
  }
}

/// The size of the border around each image
const _borderSize = 2.0;
