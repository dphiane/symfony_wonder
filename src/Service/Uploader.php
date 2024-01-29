<?php
namespace App\Service;

use Symfony\Component\Filesystem\Filesystem;
use Symfony\Component\HttpFoundation\File\UploadedFile;

//$profileFolder et profilFolderPublic: arguments service.yaml
class Uploader{
    public function __construct(private Filesystem $fs,private $profileFolder, private $profileFolderPublic) {
    }
    public function uploadProfileImage(UploadedFile $picture, string $oldPicture = null) : string {
        $folder= $this->profileFolder;
        $ext = $picture->guessExtension() ?? 'bin';
        $filename = bin2hex(random_bytes(10)). '.' . $ext;
        $picture->move($folder, $filename);
        if($oldPicture){
            $this->fs->remove($folder . '/' . pathinfo($oldPicture, PATHINFO_BASENAME));
        }
        return $this->profileFolderPublic . '/' . $filename;
    }
}