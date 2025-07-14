#!/bin/bash

# --- Existing Script with Comments ---

# 从 git 中获取最新的 tag，例如 "v1.2.3" 或 "1.2.3"
# --abbrev=0 表示不显示 commit hash 的缩写
VERSION=$(git describe --abbrev=0 --tags)
echo "Current version: $VERSION"

# 将版本号中的 "." 替换为空格，以便将其分割成数组
# 例如 "1.2.3" -> "1 2 3"
VERSION_BITS=(${VERSION//./ })

# 分别获取主要、次要和修订版本号
VNUM1=${VERSION_BITS[0]}
VNUM2=${VERSION_BITS[1]}
VNUM3=${VERSION_BITS[2]}

# 将修订版本号加 1
VNUM3=$((VNUM3+1))

# 拼接成新的 tag 字符串
NEW_TAG="$VNUM1.$VNUM2.$VNUM3"

echo "Updating $VERSION to $NEW_TAG"

# 获取当前 commit 的完整 hash
GIT_COMMIT=$(git rev-parse HEAD)

# 检查当前 commit 是否已经关联了任何 tag
# 如果当前 commit 没有 tag，`git describe` 会失败并返回空字符串
NEEDS_TAG=$(git describe --contains $GIT_COMMIT 2>/dev/null)

# 如果 $NEEDS_TAG 为空，说明当前 commit 没有 tag
if [ -z "$NEEDS_TAG" ]; then
    echo "Tagging commit with $NEW_TAG"
    # 创建新 tag
    git tag $NEW_TAG
    # 将所有本地 tag 推送到远程仓库
    git push --tags
else
    echo "This commit is already tagged with $NEEDS_TAG"
fi