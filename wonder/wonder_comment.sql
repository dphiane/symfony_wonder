-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: wonder
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` int NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `author_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_9474526C1E27F6BF` (`question_id`),
  KEY `IDX_9474526CF675F31B` (`author_id`),
  CONSTRAINT `FK_9474526C1E27F6BF` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`),
  CONSTRAINT `FK_9474526CF675F31B` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,2,'<?php\n\nnamespace App\\Controller;\n\nuse App\\Entity\\Comment;\nuse App\\Entity\\Question;\nuse App\\Form\\CommentType;\nuse App\\Form\\QuestionType;\nuse Doctrine\\ORM\\EntityManagerInterface;\nuse Symfony\\Component\\Security\\Http\\Attribute\\IsGranted;\nuse Symfony\\Component\\HttpFoundation\\Request;\nuse Symfony\\Component\\HttpFoundation\\Response;\nuse Symfony\\Component\\Routing\\Annotation\\Route;\nuse Symfony\\Bundle\\FrameworkBundle\\Controller\\AbstractController;\n\nclass QuestionController extends AbstractController\n{\n  #[Route(\'/question/ask\', name: \'question_form\')]\n  #[IsGranted(\'ROLE_USER\')]\n  public function index(Request $request, EntityManagerInterface $em): Response\n  {\n      $user = $this->getUser();\n      $question = new Question();\n      $formQuestion = $this->createForm(QuestionType::class, $question);\n\n      $formQuestion->handleRequest($request);\n\n      if ($formQuestion->isSubmitted() && $formQuestion->isValid()) {\n          $question->setNbrOfResponse(0);\n          $question->setRating(0);\n          $question->setAuthor($user);\n          $question->setCreatedAt(new \\DateTimeImmutable());\n          $em->persist($question);\n          $em->flush();\n          $this->addFlash(\'success\', \'Votre question a été ajoutée\');\n          return $this->redirectToRoute(\'home\');\n      }\n\n      return $this->render(\'question/index.html.twig\', [\n          \'form\' => $formQuestion->createView(),\n      ]);\n  }\n\n  #[Route(\'/question/{id}\', name: \'question_show\')]\n  public function show(Request $request, Question $question, EntityManagerInterface $em): Response\n  {\n      $options = [\n          \'question\' => $question\n      ];\n      $user = $this->getUser();\n      if ($user) {\n          $comment = new Comment();\n          $commentForm = $this->createForm(CommentType::class, $comment);\n          $commentForm->handleRequest($request);\n          if ($commentForm->isSubmitted() && $commentForm->isValid()) {\n              $comment->setCreatedAt(new \\DateTimeImmutable());\n              $comment->setRating(0);\n              $comment->setQuestion($question);\n              $comment->setAuthor($user);\n              $question->setNbrOfResponse($question->getNbrOfResponse() + 1);\n              $em->persist($comment);\n              $em->flush();\n              $this->addFlash(\'success\', \'Votre réponse a bien été ajoutée\');\n              return $this->redirect($request->getUri());\n          }\n          $options[\'form\'] = $commentForm->createView();\n      }\n      return $this->render(\'question/show.html.twig\', $options);\n  }\n\n  #[Route(\'/question/rating/{id}/{score}\', name: \'question_rating\')]\n  #[IsGranted(\'ROLE_USER\')]\n  public function ratingQuestion(Request $request, Question $question, int $score, EntityManagerInterface $em)\n  {\n      $question->setRating($question->getRating() + $score);\n      $em->flush();\n      $referer = $request->server->get(\'HTTP_REFERER\');\n      return $referer ? $this->redirect($referer) : $this->redirectToRoute(\'home\');\n  }\n\n  #[Route(\'/comment/rating/{id}/{score}\', name: \'comment_rating\')]\n  #[IsGranted(\'ROLE_USER\')]\n  public function ratingComment(Request $request, Comment $comment, int $score, EntityManagerInterface $em)\n  {\n      $comment->setRating($comment->getRating() + $score);\n      $em->flush();\n      $referer = $request->server->get(\'HTTP_REFERER\');\n      return $referer ? $this->redirect($referer) : $this->redirectToRoute(\'home\');\n  }\n}',1,'2024-01-24 10:48:55',4);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-29 21:56:04
