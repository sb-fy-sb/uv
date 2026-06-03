## 新增需求

### 需求：OHOS 平台检测

uv 必须在编译时通过 `cfg!(target_env = "ohos")` 检测 OHOS 平台（OHOS 的 Rust target triple 为 `aarch64-unknown-linux-ohos`，其中 `target_env = "ohos"`）。

#### 场景：在 OHOS 上运行
- **WHEN** uv 以 target triple `aarch64-unknown-linux-ohos` 编译
- **THEN** OHOS 平台标志必须为 `true`

#### 场景：在标准 Linux 上运行
- **WHEN** uv 以 target triple `aarch64-unknown-linux-gnu` 或类似编译
- **THEN** OHOS 平台标志必须为 `false`

#### 场景：在 Windows 或 macOS 上运行
- **WHEN** uv 以 Windows 或 macOS 为目标编译
- **THEN** OHOS 平台标志必须为 `false`

### 需求：OHOS 上的 HOME 重定向

在 OHOS 上，uv 必须在进程启动时、任何目录初始化之前，将 `HOME` 设置为 `/data/local/tmp`。

#### 场景：OHOS 上使用默认 HOME
- **WHEN** uv 在 OHOS 上运行
- **AND** `HOME` 未设置，或 `HOME` 设置为 `/root`
- **THEN** uv 必须在任何缓存或数据目录创建之前设置 `HOME=/data/local/tmp`

#### 场景：OHOS 上已配置可写的 HOME
- **WHEN** uv 在 OHOS 上运行
- **AND** `HOME` 已经设置为一个可写目录（不是 `/root`）
- **THEN** uv 不得覆盖 `HOME`

#### 场景：非 OHOS 平台
- **WHEN** uv 在 Linux、macOS 或 Windows 上运行
- **THEN** uv 不得修改 `HOME`

### 需求：默认路径解析到可写位置

`HOME` 重定向之后，uv 的默认存储路径必须解析到 `/data/local/tmp/` 下。

#### 场景：OHOS 上的缓存目录
- **WHEN** uv 在 OHOS 上查询默认缓存目录
- **THEN** 路径必须解析为 `/data/local/tmp/.cache/uv`

#### 场景：OHOS 上的数据目录
- **WHEN** uv 在 OHOS 上查询默认数据目录
- **THEN** 路径必须解析为 `/data/local/tmp/.local/share/uv`

### 需求：环境变量覆盖优先

用户配置的环境变量（`UV_CACHE_DIR`、`UV_DATA_DIR`、`UV_TOOL_DIR`、`XDG_CACHE_HOME`、`XDG_DATA_HOME` 等）必须始终优先于基于 `HOME` 的默认值。

#### 场景：OHOS 上设置了 UV_CACHE_DIR
- **WHEN** `UV_CACHE_DIR` 在 OHOS 上设置为自定义路径
- **THEN** uv 必须使用自定义路径，而不是 `/data/local/tmp/.cache/uv`

#### 场景：OHOS 上设置了 XDG_CACHE_HOME
- **WHEN** `XDG_CACHE_HOME` 在 OHOS 上被设置
- **THEN** uv 必须使用 `$XDG_CACHE_HOME/uv` 作为缓存目录

### 需求：重定向发生在目录初始化之前

`HOME` 重定向必须在 `crates/uv/src/lib.rs` 的 `main()` 函数中执行，紧接在平台设置之后、任何 clap 参数解析或缓存初始化之前。

#### 场景：OHOS 上缓存初始化成功
- **WHEN** uv 在 OHOS 上启动，未设置任何环境变量
- **THEN** 缓存目录必须在 `/data/local/tmp/.cache/uv` 下成功创建
- **AND** 不得出现 `Read-only file system` 错误

### 需求：非 OHOS 平台零运行时开销

OHOS 检测和重定向代码在非 OHOS 平台上必须零运行时开销，使用编译时 `cfg!` 保护。

#### 场景：Linux 上的二进制体积
- **WHEN** uv 为 Linux 编译
- **THEN** 二进制中不得包含任何 OHOS 相关的代码或字符串
