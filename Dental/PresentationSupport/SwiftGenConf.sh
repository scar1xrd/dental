
RSROOT=$SRCROOT/Dental/PresentationSupport/Resources
RSROOTGENERATED=$RSROOT/Generated

"$PODS_ROOT/SwiftGen/bin/swiftgen" \
xcassets -t swift3 "$RSROOT/Assets.xcassets" \
--output "$RSROOTGENERATED/Assets.swift"

"$PODS_ROOT/SwiftGen/bin/swiftgen" \
strings -t structured-swift4 "$RSROOT/Localizable.strings" \
--output "$RSROOTGENERATED/L10n.swift"

"$PODS_ROOT/SwiftGen/bin/swiftgen" \
fonts -t swift4 "$RSROOT/Fonts" \
--output "$RSROOTGENERATED/FontsFamily.swift"
