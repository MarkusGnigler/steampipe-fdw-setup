#!/bin/sh

set -e

OS=$(uname -s)
if [ "$OS" = "Windows_NT" ]; then
    echo "Error: Windows is not supported yet." 1>&2
    exit 1
else
    UNAME_SM=$(uname -sm)
    case "$UNAME_SM" in
        "Darwin x86_64") target="darwin_amd64.tar.gz" ;;
        "Darwin arm64") target="darwin_arm64.tar.gz" ;;
        "Linux x86_64") target="linux_amd64.tar.gz" ;;
        "Linux aarch64") target="linux_arm64.tar.gz" ;;
        *) echo "Error: '$UNAME_SM' is not supported yet." 1>&2; exit 1 ;;
    esac
fi


PG_VERSION=14
#$(pg_config --sharedir)/extension
PG_DIR=" /usr/share/postgresql/$PG_VERSION/extension/"

plugin=$1
version=${2:-latest}
location="$(pwd)/drivers/"
asset_name="steampipe_postgres_${plugin}.pg${PG_VERSION}.${target}"
if [ "$version" = "latest" ]; then
	uri="https://github.com/turbot/steampipe-plugin-${plugin}/releases/latest/download/${asset_name}"
else
	uri="https://github.com/turbot/steampipe-plugin-${plugin}/releases/download/${version}/${asset_name}"
fi

# download extension
if ! curl --fail --location --progress-bar --output ${asset_name} "$uri"; then
	echo "Could not find version $version on - $uri"
	exit 1
fi

# If the .gz file is expected to contain a tar archive then extract it
tar -xzvf $asset_name

# Remove the downloaded tar.gz file
rm -f $asset_name

echo ""
echo "Download and extraction completed."
echo ""
echo "Installing steampipe_postgres_${plugin} in ${BOLD}$PG_DIR${NORMAL}..."
echo ""
# Get the name of the extracted directory
ext_dir=$(echo $asset_name | sed 's/\.tar\.gz$//')
cd $ext_dir

# Get directories from pg_config
PG_CONFIG=$(command -v pg_config)
LIBDIR=$($PG_CONFIG --pkglibdir)
EXTDIR=$($PG_CONFIG --sharedir)/extension/

# Copy the files to the PostgreSQL installation directory
cp steampipe_postgres_${plugin}.so "$LIBDIR"
cp steampipe_postgres_${plugin}.control "$EXTDIR"
cp steampipe_postgres_${plugin}--1.0.sql "$EXTDIR"

# Check if the files were copied correctly
if [ $? -eq 0 ]; then
	echo "Successfully installed steampipe_postgres_${plugin} extension!"
	echo ""
	echo "Files have been copied to:"
	echo "- Library directory: ${LIBDIR}"
	echo "- Extension directory: ${EXTDIR}"
	cd ../
	rm -rf $ext_dir
else
	echo -e "\e[31mFailed to install steampipe_postgres_${plugin} extension. Please check permissions and try again.\e[0m"
	exit 1
fi
#!/bin/sh

set -e

OS=$(uname -s)
if [ "$OS" = "Windows_NT" ]; then
    echo "Error: Windows is not supported yet." 1>&2
    exit 1
else
    UNAME_SM=$(uname -sm)
    case "$UNAME_SM" in
        "Darwin x86_64") target="darwin_amd64.tar.gz" ;;
        "Darwin arm64") target="darwin_arm64.tar.gz" ;;
        "Linux x86_64") target="linux_amd64.tar.gz" ;;
        "Linux aarch64") target="linux_arm64.tar.gz" ;;
        *) echo "Error: '$UNAME_SM' is not supported yet." 1>&2; exit 1 ;;
    esac
fi


PG_VERSION=14
#$(pg_config --sharedir)/extension
PG_DIR=" /usr/share/postgresql/$PG_VERSION/extension/"

plugin=$1
version=${2:-latest}
location="$(pwd)/drivers/"
asset_name="steampipe_postgres_${plugin}.pg${PG_VERSION}.${target}"
if [ "$version" = "latest" ]; then
	uri="https://github.com/turbot/steampipe-plugin-${plugin}/releases/latest/download/${asset_name}"
else
	uri="https://github.com/turbot/steampipe-plugin-${plugin}/releases/download/${version}/${asset_name}"
fi

# download extension
if ! curl --fail --location --progress-bar --output ${asset_name} "$uri"; then
	echo "Could not find version $version on - $uri"
	exit 1
fi

# If the .gz file is expected to contain a tar archive then extract it
tar -xzvf $asset_name

# Remove the downloaded tar.gz file
rm -f $asset_name

echo ""
echo "Download and extraction completed."
echo ""
echo "Installing steampipe_postgres_${plugin} in ${BOLD}$PG_DIR${NORMAL}..."
echo ""
# Get the name of the extracted directory
ext_dir=$(echo $asset_name | sed 's/\.tar\.gz$//')
cd $ext_dir

# Get directories from pg_config
PG_CONFIG=$(command -v pg_config)
LIBDIR=$($PG_CONFIG --pkglibdir)
EXTDIR=$($PG_CONFIG --sharedir)/extension/

# Copy the files to the PostgreSQL installation directory
cp steampipe_postgres_${plugin}.so "$LIBDIR"
cp steampipe_postgres_${plugin}.control "$EXTDIR"
cp steampipe_postgres_${plugin}--1.0.sql "$EXTDIR"

# Check if the files were copied correctly
if [ $? -eq 0 ]; then
	echo "Successfully installed steampipe_postgres_${plugin} extension!"
	echo ""
	echo "Files have been copied to:"
	echo "- Library directory: ${LIBDIR}"
	echo "- Extension directory: ${EXTDIR}"
	cd ../
	rm -rf $ext_dir
else
	echo -e "\e[31mFailed to install steampipe_postgres_${plugin} extension. Please check permissions and try again.\e[0m"
	exit 1
fi
