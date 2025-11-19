BUILD_DIR      	:= build
CMAKE          	:= cmake
BUILD_TOOL     	:= ninja
LLVM_FLAGS		:= -DLLVM_TARGETS_TO_BUILD="X86" \
					-DLLVM_ENABLE_PROJECTS="" \
					-DLLVM_BUILD_EXAMPLES=ON \
					-DLLVM_INCLUDE_EXAMPLES=ON \

RELEASE_DIR		:= $(BUILD_DIR)/release
DEBUG_DIR		:= $(BUILD_DIR)/debug

# 可执行程序路径
# EXECUTABLE := $(BUILD_DIR)/release/bin/myapp$(if $(filter Windows_NT,$(OS)),.exe,)

.PHONY: all run release_llvm debug_llvm clean_llvm distclean_llvm help

all: release_llvm

# 配置并构建调试版本
# debug:
# 	@mkdir -p $(DEBUG_DIR)
# 	@cd $(DEBUG_DIR) && $(CMAKE) -G Ninja $(CMAKE_FLAGS) ../..  # 添加 Ninja 生成器
# 	@$(BUILD_TOOL) -C $(DEBUG_DIR)
# 	@cd $(DEBUG_DIR) && rm -rf ./src

# 配置并构建发布版本
run: debug_llvm
	@./$(DEBUG_DIR)/bin/Kaleidoscope-Ch2

release_llvm:
	@mkdir -p $(RELEASE_DIR)
	@cd $(RELEASE_DIR) && $(CMAKE) -G Ninja -DCMAKE_BUILD_TYPE=Release $(LLVM_FLAGS) ../..  # 添加模块支持
	@cd $(RELEASE_DIR) && ninja

debug_llvm:
	@mkdir -p $(DEBUG_DIR)
	@cd $(DEBUG_DIR) && $(CMAKE) -G Ninja -DCMAKE_BUILD_TYPE=Debug $(LLVM_FLAGS) ../..  # 添加模块支持
	@cd $(DEBUG_DIR) && ninja -j 5
	
clean_llvm:
	@[ -d $(RELEASE_DIR) ] && $(BUILD_TOOL) -C $(RELEASE_DIR) clean || true
	@[ -d $(DEBUG_DIR) ] && $(BUILD_TOOL) -C $(DEBUG_DIR) clean || true

distclean_llvm:
	@rm -rf $(RELEASE_DIR)
	@rm -rf $(DEBUG_DIR)

help:
	@echo "可用目标:"
	@echo "  all       - 默认构建 (release版本)"
	@echo "  debug     - 调试构建"
	@echo "  release   - 发布构建 (默认)"
	@echo "  run       - 构建并运行程序 (release)"
	@echo "  run_debug - 构建并运行debug版本"
	@echo "  test      - 运行测试"
	@echo "  clean     - 清理构建文件"
	@echo "  distclean - 删除整个构建目录"
	@echo "  help      - 显示帮助信息"

# 添加 Ninja 检查
check-ninja:
ifeq (, $(shell which ninja))
	$(error "Ninja 构建工具未安装，请先安装 ninja (https://ninja-build.org/)")
endif