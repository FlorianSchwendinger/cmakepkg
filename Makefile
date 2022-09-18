PKG=cmakepkg
R ?= R
Rclang ?= R412-clang

readme:
	$(R) -e 'rmarkdown::render("README.Rmd", clean = FALSE)'

compile_attributes:
	$(R) -e 'Rcpp::compileAttributes(".")'

docs:
	$(R) -e 'library("roxygen2"); roxygenize(".", c("rd", "namespace"), load_source)'

build: compile_attributes docs
	$(R) CMD build .

inst: build
	$(R) CMD INSTALL ${PKG}*.tar.gz
	
check: build
	$(R) CMD check ${PKG}*.tar.gz

check_as_cran: build
	$(R) CMD check --as-cran ${PKG}*.tar.gz


clang_compile_attributes:
	$(Rclang) -e 'Rcpp::compileAttributes(".")'

clang_build: clang_compile_attributes
	$(Rclang) CMD build .

clang_inst: clang_build
	$(Rclang) CMD INSTALL ${PKG}*.tar.gz

clang_check: build
	$(Rclang) CMD check ${PKG}*.tar.gz

clang_check_as_cran: build
	$(Rclang) CMD check --as-cran ${PKG}*.tar.gz


manual: clean
	$(R) CMD Rd2pdf --output=Manual.pdf .

clean:
	rm -f Manual.pdf README.knit.md README.html
	rm -rf .Rd2pdf*
	rm -rf ${PKG}.Rcheck

check_all: build
	$(R) -e "rhub::check(dir(pattern = '${PKG}_.*.tar.gz'), platform = c('macos-highsierra-release-cran', 'macos-m1-bigsur-release', 'windows-x86_64-devel', 'fedora-clang-devel'))"

check_fedora: build
	$(R) -e "rhub::check(dir(pattern = '${PKG}_.*.tar.gz'), platform = 'fedora-clang-devel')"

check_win: build
	$(R) -e "rhub::check(dir(pattern = '${PKG}_.*.tar.gz'), platform = 'windows-x86_64-devel')"

check_old_win: build
	$(R) -e "rhub::check(dir(pattern = '${PKG}_.*.tar.gz'), platform = 'windows-x86_64-devel')"

devcheck_win_devel: build
	$(R) -e "devtools::check_win_devel(email = 'FlorianSchwendinger@gmx.at')"

devcheck_win_release: build
	$(R) -e "devtools::check_win_release(email = 'FlorianSchwendinger@gmx.at')"

devcheck_win_oldrelease: build
	$(R) -e "devtools::check_win_oldrelease(email = 'FlorianSchwendinger@gmx.at')"

check_mac_m1: build
	$(R) -e "rhub::check(dir(pattern = '${PKG}_.*.tar.gz'), platform = 'macos-m1-bigsur-release')"

check_mac_old: build
	$(R) -e "rhub::check(dir(pattern = '${PKG}_.*.tar.gz'), platform = 'macos-highsierra-release-cran')"
