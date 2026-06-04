{ pkgs, ... }: 
{
  # Serviço Oneshot Systemd no Initrd para Rollback Automático
  boot.initrd.systemd.services.zfs-root-rollback = {
    description = "Rollback ZFS root dataset to pristine @blank state";
    wantedBy = [ "initrd.target" ];
    # Garante que roda após o pool ser importado e antes de montar o /
    after = [ "zfs-import-zroot.service" ];
    before = [ "sysroot.mount" ];
    path = [ pkgs.zfs ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      echo "Wiping root filesystem..."
      # O parâmetro -r garante um rollback limpo destruindo snapshots intermediários se houverem
      zfs rollback -r zroot/local/root@blank
    '';
  };

  # Configuração básica do Impermanence (Exemplo usando o módulo nativo de environment)
  # Garante que caminhos críticos sejam vinculados ao seu dataset persistente
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd"
      "/etc/nixos" # Mantém seu repositório git/configurações localmente se preferir
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };

  # Permite que usuários normais gerenciem mounts FUSE (necessário para impermanence)
  programs.fuse.userAllowOther = true;
}